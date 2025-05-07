REPO_URL="$1"
FOLDER_PATH="$2"
BRANCH="$3"

if [ -z "$REPO_URL" ] || [ -z "$FOLDER_PATH" ] || [ -z "$BRANCH" ]; then
  echo "Uso: $0 <repo-url> <folder-path> <branch>"
  exit 1
fi

REPO_DIR=$(basename "$REPO_URL" .git)
git clone --filter=blob:none --no-checkout "$REPO_URL" "$REPO_DIR"
cd "$REPO_DIR" || exit 2

git sparse-checkout init --cone 
git sparse-checkout set "$FOLDER_PATH"

git checkout "$BRANCH" || exit 3

echo "✅ Sparse clone finished, new folder is: $REPO_DIR"

exit 0
