# coinbase-pro

Client for Coinabse Pro REST and Websocket APIS.

Here is a list of implemented/unimplemented features:

- Market Data
    - [x] Products
        - [x] Get Products
        - [x] Get Product Order Book
        - [x] Get Product Ticker
        - [x] Get Trades
        - [x] Get Historic Rates
        - [x] Get 24hr Stats
    - [x] Currencies
        - [x] Get Currencies
    - [x] Time
- Private
    - [ ] Accounts
        - [x] List Accounts
        - [x] Get An Account
        - [ ] Get Account History
        - [ ] Get Holds
    - [x] Orders
        - [x] Place a New Order
        - [x] Cancel an Order
        - [x] Cancel all
        - [x] List Orders
        - [x] Get an Order
    - [x] Fills
        - [x] List Fills
    - [ ] Deposits
        - [ ] Payment Method
        - [ ] Coinbase
    - [ ] Withdrawals
        - [ ] Payment Method
        - [ ] Coinbase
        - [ ] Crypto
    - [ ] Stablecoin Conversions
        - [ ] Create Conversion
    - [ ] Payment Methods
        - [ ] List Payment Methods
    - [x] Fees
        - [x] Get Current Fees
    - [ ] Reports
        - [ ] Create a new report
        - [ ] Get report status
    - [x] User Account
        - [x] Trailing Volume
- Websocket Feed
    - [x] Channels
        - [x] The heartbeat channel
        - [x] The status channel
        - [x] The ticker channel
        - [x] The level2 channel
        - [x] The user channel
        - [x] The matches channel
        - [x] The full channel
- FIX API
    - [ ] Messages


## Request API

### Market Data Requests

```haskell
run (trades (ProductId "BTC-USD")) >>= print
```

### Authenticated Private Requests

```haskell
runCbAuthT cpc $ do
    fills (Just btcusd) Nothing >>= liftIO . print
  where
    accessKey  = CBAccessKey "<access-key>"
    secretKey  = CBSecretKey "<secret-key>"
    passphrase = CBAccessPassphrase "<passphrase>"
    cpc        = CoinbaseProCredentials accessKey secretKey passphrase
```

## Websocket API

To print out all of the full order book updates for BTC-USD:


```haskell
main :: IO ()
main = do
    msgs <- subscribeToFeed [ProductId "BTC-USD"] [Ticker] Nothing
    forever $ Streams.read msgs >>= print
```

## Example

Example execs can be found in `src/example/`
