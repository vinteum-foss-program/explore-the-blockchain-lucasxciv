# Only one single output remains unspent from block 123,321. What address was it sent to?

hash=$(bitcoin-cli getblockhash 123321)
txns=$(bitcoin-cli getblock "$hash" 2 | jq -c '.tx[]' | tr -d ' ')

for txn in $txns; do
  txId=$(echo "$txn" | jq -r '.txid')
  vOuts=$(echo "$txn" | jq -c '.vout[]' | tr -d ' ')

  for vOut in $vOuts; do
    vOutNumber=$(echo "$vOut" | jq -r '.n')
    unspent=$(bitcoin-cli gettxout "$txId" "$vOutNumber")

    if [ "$unspent" != "" ]; then
      echo "$unspent" | jq -r '.scriptPubKey.address'
      break 2
    fi
  done
done
