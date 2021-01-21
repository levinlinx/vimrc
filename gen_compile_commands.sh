BUILDDIR=$(dirname "$0")
cd $BUILDDIR
cmake .. -DCODM_VERSION:STRING=west -DBUILD_TYPE:STRING=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
mv compile_commands.json ..
cd ..

init_arg="{\"clang\":{\"resourceDir\": \"$HOME/.vim/plugged/vim-tcpp/plugin/../clang\"}}"
~/.vim/plugged/vim-tcpp/bin/ccls --index=. --init="$init_arg" --log-file=/tmp/ccls_west.log -v=1
