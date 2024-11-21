# How many new outputs were created by block 123,456?

hash=$(bitcoin-cli getblockhash 123456)
txns=$(bitcoin-cli getblock $hash 2)

outputs=0
for txn in $(echo $txns | jq -c '.tx[]' | tr -d ' '); do
  outputs=$((outputs + $(echo "$txn" | jq '.vout | length')))
done

echo $outputs
