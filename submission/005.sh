# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

txId="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"
tx=$(bitcoin-cli getrawtransaction $txId 2 | jq -c '.vin[]' | tr -d ' ')

pubKeys=""
for vin in $tx; do
  pubKeys="$pubKeys $(echo "$vin" | jq '.txinwitness[1]')"
done

address=$(bitcoin-cli createmultisig 1 "[$(echo "$pubKeys" | tr ' ' ',' | cut -c 2-)]" | jq -r '.address')

echo "$address"
