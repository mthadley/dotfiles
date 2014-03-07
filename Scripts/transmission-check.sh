#!/usr/bin/bash
# Transmission stats

ACTIVE=$(expr $(transmission-remote -tactive -l | wc -l) - 2)
TOTAL=$(expr $(transmission-remote -l | wc -l) - 2)

echo -n "$ACTIVE/$TOTAL"
