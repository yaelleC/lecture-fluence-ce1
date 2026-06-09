#!/bin/bash
# =============================================================================
#  Combien de fois le livret a-t-il été téléchargé ?  ·  GitHub Releases
#
#  USAGE :  ./download_stats.sh
#
#  Affiche le nombre de téléchargements de chaque fichier attaché à une
#  "Release" GitHub. (Les fichiers simplement présents dans le dépôt ne sont
#  PAS comptés : seuls les fichiers d'une Release le sont.)
#
#  Le dépôt est détecté automatiquement depuis « git remote origin ».
#  Aucune authentification n'est nécessaire pour un dépôt public.
#
#  Pré-requis : curl, jq.
# =============================================================================

set -e
cd "$(dirname "$0")"

# Déduit "proprietaire/depot" depuis l'URL du remote (SSH ou HTTPS).
REMOTE=$(git remote get-url origin 2>/dev/null || true)
REPO=$(printf '%s' "$REMOTE" | sed -E 's#(git@github.com:|https://github.com/)##; s#\.git$##')

if [ -z "$REPO" ]; then
  echo "❌  Impossible de détecter le dépôt GitHub (git remote 'origin' manquant ?)."
  exit 1
fi

echo "Dépôt : $REPO"
echo

JSON=$(curl -fsSL "https://api.github.com/repos/$REPO/releases") || {
  echo "❌  Appel à l'API GitHub échoué (dépôt privé ou inexistant ?)."
  exit 1
}

count=$(printf '%s' "$JSON" | jq 'length')
if [ "$count" = "0" ]; then
  echo "Aucune Release pour l'instant — donc aucun téléchargement à compter."
  echo "Crée une release avec :  gh release create v1.0 livret_lecture_CE1_v2.pdf"
  exit 0
fi

# Tableau : release | fichier | téléchargements
printf '%s' "$JSON" | jq -r '
  .[] | .tag_name as $t | .assets[]
  | [$t, .name, (.download_count|tostring)] | @tsv' \
  | awk -F'\t' 'BEGIN{printf "%-12s %-32s %s\n", "RELEASE", "FICHIER", "TÉLÉCHARGEMENTS"}
                {printf "%-12s %-32s %s\n", $1, $2, $3; total+=$3}
                END{printf "\nTotal : %d téléchargements\n", total}'
