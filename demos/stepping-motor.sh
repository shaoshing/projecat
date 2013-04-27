DELAY=0
count=150

while true;do
  echo "Right"
  for ((i=1; i<=$count; i++)); do
    gpio write 0 1
    gpio write 1 0
    gpio write 2 0
    gpio write 3 0
    sleep $DELAY

    gpio write 0 0
    gpio write 1 1
    gpio write 2 0
    gpio write 3 0
    sleep $DELAY

    gpio write 0 0
    gpio write 1 0
    gpio write 2 1
    gpio write 3 0
    sleep $DELAY

    gpio write 0 0
    gpio write 1 0
    gpio write 2 0
    gpio write 3 1
    sleep $DELAY
  done

  echo "Left"
  for ((i=1; i<=$count; i++)); do
    gpio write 0 0
    gpio write 1 0
    gpio write 2 0
    gpio write 3 1
    sleep $DELAY

    gpio write 0 0
    gpio write 1 0
    gpio write 2 1
    gpio write 3 0
    sleep $DELAY

    gpio write 0 0
    gpio write 1 1
    gpio write 2 0
    gpio write 3 0
    sleep $DELAY

    gpio write 0 1
    gpio write 1 0
    gpio write 2 0
    gpio write 3 0
    sleep $DELAY
  done
done
