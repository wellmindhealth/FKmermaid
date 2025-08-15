@echo off
REM FKmermaid Environment Setup
REM Sets NODE_PATH to use the moved node_modules folder

echo 🔧 Setting NODE_PATH for FKmermaid project...

set NODE_PATH=D:\GIT\farcry\node_modules
echo ✅ NODE_PATH set to: %NODE_PATH%

REM Verify the path exists
if exist "%NODE_PATH%" (
    echo ✅ Node modules directory exists at: %NODE_PATH%
    
    REM Check if mermaid-cli is available
    if exist "%NODE_PATH%\.bin\mmdc.cmd" (
        echo ✅ Mermaid CLI found
    ) else (
        echo ⚠️  Mermaid CLI not found at expected location
        echo    Expected: %NODE_PATH%\.bin\mmdc.cmd
    )
) else (
    echo ❌ Node modules directory not found at: %NODE_PATH%
    echo    Please ensure the node_modules folder has been moved to the correct location
)

echo.
echo 💡 To make this permanent, add to your system environment variables:
echo    NODE_PATH = d:/farcry/node_modules
echo.
echo 🚀 You can now run npx commands that will use the moved node_modules!
echo.
pause
