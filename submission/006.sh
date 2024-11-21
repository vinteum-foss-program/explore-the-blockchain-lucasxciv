# Which tx in block 257,343 spends the coinbase output of block 256,128?

block257343=$(bitcoin-cli getblockhash 257343)
coinbase=$(bitcoin-cli getblock "$(bitcoin-cli getblockhash 256128)" | jq -r '.tx[0]')

for tx in $(bitcoin-cli getblock "$block257343" 2 | jq -c '.tx[]' | tr -d ' '); do
  for input in $(echo "$tx" | jq -c '.vin[]' | tr -d ' '); do
    if [ "$(echo "$input" | jq -r '.txid')" = "$coinbase" ]; then
      echo "$tx" | jq -r '.txid'
      break 2
    fi
  done
done
