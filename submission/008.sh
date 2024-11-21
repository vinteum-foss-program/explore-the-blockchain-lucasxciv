# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

txId="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
txInWitness=$(bitcoin-cli getrawtransaction $txId 2 | jq -r '.vin[0].txinwitness[2]')
decodeScript=$(bitcoin-cli decodescript "$txInWitness" | jq -r '.asm')
signedPublicKey=$(echo "$decodeScript" | awk '{print $2}')

echo "$signedPublicKey"

#publicKey=$(echo "$txInWitness" | grep -oP '(?<=6321)[0-9a-fA-F]{66}')
#echo "$publicKey"
