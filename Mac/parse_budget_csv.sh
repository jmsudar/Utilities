#!/usr/bin/env bash
# usage: ./parse_budget_csv.sh <Month> <Year> [file]

MONTH=$(printf "%d" "$1")
YEAR="$2"
FILE="${3:-budget.csv}"

echo "=== Spending by Category: $YEAR-$(printf "%02d" $MONTH) ==="
awk -F',' -v m="$MONTH" -v y="$YEAR" '
  NR==1 { next }
  {
    split($1, d, "/")
    if (d[1]+0 == m+0 && d[3] == y) {
      amt = $2; gsub(/[$,]/, "", amt)
      cat[$4] += amt
      total   += amt
    }
  }
  END {
    for (c in cat) printf "  %-20s $%10.2f\n", c, cat[c]
  }
' "$FILE" | sort
printf "  %-20s $%10.2f\n" "TOTAL" \
  "$(awk -F',' -v m="$MONTH" -v y="$YEAR" '
    NR==1{next}
    { split($1,d,"/"); if(d[1]+0==m+0 && d[3]==y){ amt=$2; gsub(/[$,]/,"",amt); t+=amt } }
    END{print t}
  ' "$FILE")"

echo ""
echo "=== Recurring Charges: $YEAR-$(printf "%02d" $MONTH) ==="
awk -F',' -v m="$MONTH" -v y="$YEAR" '
  NR==1 { next }
  {
    split($1, d, "/")
    if (d[1]+0 == m+0 && d[3] == y && $5 == "Yes") {
      amt = $2; gsub(/[$,]/, "", amt)
      recur += amt
      printf "  %-25s $%8.2f\n", $3, amt
    }
  }
  END { printf "  %-25s $%8.2f\n", "RECURRING TOTAL", recur }
' "$FILE"