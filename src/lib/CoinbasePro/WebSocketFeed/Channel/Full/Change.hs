{-# LANGUAGE OverloadedStrings #-}

module CoinbasePro.WebSocketFeed.Channel.Full.Change
    ( Change (..)
    ) where

import           Data.Aeson        (FromJSON (..), withObject, (.:), (.:?))
import           Data.Time.Clock   (UTCTime)

import           CoinbasePro.Types (OrderId, Price, ProductId, Sequence, Side,
                                    Size)


data Change = Change
    { time      :: UTCTime
    , sequence  :: Sequence
    , orderId   :: OrderId
    , productId :: ProductId
    , newSize   :: Maybe Size
    , oldSize   :: Maybe Size
    , newFunds  :: Maybe Double
    , oldFunds  :: Maybe Double
    , price     :: Maybe Price
    , side      :: Side
    } deriving (Eq, Ord, Show)


instance FromJSON Change where
    parseJSON = withObject "change" $ \o -> do
      ti   <- o .: "time"
      sq   <- o .: "sequence"
      oid  <- o .: "order_id"
      prid <- o .: "product_id"
      ns   <- o .:? "new_size"
      os   <- o .:? "old_size"
      nf   <- o .:? "new_funds"
      olf  <- o .:? "old_funds"
      p    <- o .:? "price"
      s    <- o .: "side"
      return $ Change ti sq oid prid
          (read <$> ns) (read <$> os) (read <$> nf) (read <$> olf) (read <$> p) s
