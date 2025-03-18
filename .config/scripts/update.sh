# References: Fernando Cejas (https://fernandocejas.com/blog/engineering/2022-03-30-arch-linux-system-maintance/)
echo "----------------------------------------------------"
echo "UPDATING SYSTEM"
echo "----------------------------------------------------"

paru -Syu

echo ""
echo "----------------------------------------------------"
echo "CLEARING PACMAN CACHE"
echo "----------------------------------------------------"
echo ""
echo "Clearing Cache, leaving newest 2 versions:"
paccache -vrk2
echo ""
echo "Clearing all uninstalled packages:"
paccache -ruk0
echo ""
echo "----------------------------------------------------"
echo "REMOVING ORPHANED PACKAGES"
echo "----------------------------------------------------"

orphaned=$(paru -Qdtq)
if [ -n "$orphaned" ]; then
    echo "$orphaned" | paru -Rns -
else
    echo "No orphaned packages to remove."
fi

echo ""
echo "----------------------------------------------------"
echo "CLEARING HOME CACHE"
echo "----------------------------------------------------"
echo "Clearing ~/.cache/..."
rm -rf ~/.cache/
echo ""
echo "----------------------------------------------------"
echo "CLEARING SYSTEM LOGS"
echo "----------------------------------------------------"
sudo journalctl --vacuum-time=7d
