frames=(
"󰯉 "
" 󰯉 "
"  󰯉 "
"   󰯉 "
"    󰯉 "
"   󰯉 "
"  󰯉 "
" 󰯉 "
)

state_file="/tmp/invaders_frame_index"

if [[ ! -f $state_file ]]; then
  echo 0 > "$state_file"
fi

index=$(cat "$state_file")
echo -e "${frames[$index]}"

next_index=$(( (index + 1) % ${#frames[@]} ))
echo $next_index > "$state_file"
