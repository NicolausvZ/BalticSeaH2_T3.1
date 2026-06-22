#!/usr/bin/env bash
set -euo pipefail
HYPE="/home/lwlassi/development/hype-code/hype"

echo "========================================"
echo "Running HYPE for 15 catchment(s)..."
echo "========================================"

echo "-> Running Hounijoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Hounijoki/hype_data/"

echo "-> Running Vironjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Vironjoki/hype_data/"

echo "-> Running Summajoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Summajoki/hype_data/"

echo "-> Running Taasianjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Taasianjoki/hype_data/"

echo "-> Running Koskenkylanjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Koskenkylanjoki/hype_data/"

echo "-> Running Ilolanjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Ilolanjoki/hype_data/"

echo "-> Running Porvoonjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Porvoonjoki/hype_data/"

echo "-> Running Mustijoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Mustijoki/hype_data/"

echo "-> Running Sipoonjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Sipoonjoki/hype_data/"

echo "-> Running Vantaanjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Vantaanjoki/hype_data/"

echo "-> Running Siuntionjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Siuntionjoki/hype_data/"

echo "-> Running Karjaanjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Karjaanjoki/hype_data/"

echo "-> Running Uskelanjoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Uskelanjoki/hype_data/"

echo "-> Running Aurajoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Aurajoki/hype_data/"

echo "-> Running Sirppujoki..."
"$HYPE" "/home/lwlassi/projects/BalticSeaH2/model_setups/catchments/Sirppujoki/hype_data/"

echo "========================================"
echo "All catchments complete!"
echo "========================================"
