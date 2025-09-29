@echo on
@setlocal EnableDelayedExpansion

go build -buildmode=pie -trimpath -o=%LIBRARY_PREFIX%\bin\%PKG_NAME%.exe -ldflags="-s" || goto :error
go-licenses save . --save_path=license-files --ignore=github.com/pb33f/doctor --ignore=github.com/dop251/goja || goto :error

:: Manually copy licenses that go-licenses could not download
xcopy /s %RECIPE_DIR%\license-files\* %SRC_DIR%\license-files || goto :error

goto :eof

:error
echo Failed with error #%errorlevel%.
exit 1
