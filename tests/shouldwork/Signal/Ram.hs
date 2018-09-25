module Ram where

import Clash.Prelude
import qualified Clash.Explicit.Prelude as Explicit
import Clash.Explicit.Testbench
import qualified Data.List as L

zeroAt0
  :: HiddenClockReset domain gated synchronous
  => Signal domain (Unsigned 8,Unsigned 8)
  -> Signal domain (Unsigned 8,Unsigned 8)
zeroAt0 a = mux en a (bundle (0,0))
  where
    en = register False (pure True)

topEntity
  :: Clock System Source
  -> Reset System Asynchronous
  -> Signal System (Unsigned 8)
  -> Signal System (Unsigned 8,Unsigned 8)
topEntity = exposeClockReset go where
  go rd = zeroAt0 dout where
    dout = asyncRamPow2 rd (Just <$> bundle (wr, bundle (wr,wr)))
    wr   = register 1 (wr + 1)
{-# NOINLINE topEntity #-}

testBench :: Signal System Bool
testBench = done
  where
    testInput      = Explicit.register clk rst 0 (testInput + 1)
    expectedOutput = outputVerifier clk rst $(listToVecTH $ L.map (\x -> (x,x)) [0::Unsigned 8,1,2,3,4,5,6,7,8])
    done           = expectedOutput (topEntity clk rst testInput)
    clk            = tbSystemClockGen (not <$> done)
    rst            = systemResetGen