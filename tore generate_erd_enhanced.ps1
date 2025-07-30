warning: in the working copy of 'src/powershell/generate_erd_enhanced.ps1', LF will be replaced by CRLF the next time Git touches it
[1mdiff --git a/src/powershell/generate_erd_enhanced.ps1 b/src/powershell/generate_erd_enhanced.ps1[m
[1mindex 1e73c75..00944e4 100644[m
[1m--- a/src/powershell/generate_erd_enhanced.ps1[m
[1m+++ b/src/powershell/generate_erd_enhanced.ps1[m
[36m@@ -62,7 +62,8 @@[m [mparam([m
     [switch]$Help = $false,[m
     [string]$ConfigFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json",[m
     [string]$OutputFile = "",[m
[31m-    [switch]$Debug[m
[32m+[m[32m    [switch]$Debug,[m
[32m+[m[32m    [string]$MermaidMode = "edit"[m
 )[m
 [m
 # Import logging modules[m
[36m@@ -428,11 +429,24 @@[m [mfunction Get-CFCRelationships {[m
                             Write-Host "`r📁 Processing: $entityName [$progress%]   " -NoNewline[m
                             [m
                             $content = Get-Content $cfcFile.FullName -Raw[m
[31m-                            # Extract entity info[m
[32m+[m[32m                            # Extract entity info with domain assignment[m
[32m+[m[32m                            $domain = "unknown"[m
[32m+[m[32m                            foreach ($domainName in $domainsConfig.PSObject.Properties.Name) {[m
[32m+[m[32m                                $domainConfig = $domainsConfig.$domainName[m
[32m+[m[32m                                foreach ($category in $domainConfig.entities.PSObject.Properties) {[m
[32m+[m[32m                                    if ($category.Value -contains $entityName) {[m
[32m+[m[32m                                        $domain = $domainName[m
[32m+[m[32m                                        break[m
[32m+[m[32m                                    }[m
[32m+[m[32m                                }[m
[32m+[m[32m                                if ($domain -ne "unknown") { break }[m
[32m+[m[32m                            }[m
[32m+[m[41m                            [m
                             $relationships.entities += @{[m
                                 name = $entityName[m
                                 plugin = $pluginName[m
                                 file = $cfcFile.FullName[m
[32m+[m[32m                                domain = $domain[m
                             }[m
                             [m
                             # Use the optimized relationship detection from the module[m
[36m@@ -468,11 +482,24 @@[m [mfunction Get-CFCRelationships {[m
                                 Write-Host "`r📁 Processing: $entityName [$progress%]   " -NoNewline[m
                                 [m
                                 $content = Get-Content $cfcFile.FullName -Raw[m
[31m-                                # Extract entity info[m
[32m+[m[32m                                # Extract entity info with domain assignment[m
[32m+[m[32m                                $domain = "unknown"[m
[32m+[m[32m                                foreach ($domainName in $domainsConfig.PSObject.Properties.Name) {[m
[32m+[m[32m                                    $domainConfig = $domainsConfig.$domainName[m
[32m+[m[32m                                    foreach ($category in $domainConfig.entities.PSObject.Properties) {[m
[32m+[m[32m                                        if ($category.Value -contains $entityName) {[m
[32m+[m[32m                                            $domain = $domainName[m
[32m+[m[32m                                            break[m
[32m+[m[32m                                        }[m
[32m+[m[32m                                    }[m
[32m+[m[32m                                    if ($domain -ne "unknown") { break }[m
[32m+[m[32m                                }[m
[32m+[m[41m                                [m
                                 $relationships.entities += @{[m
                                     name = $entityName[m
[31m-                                        plugin = $pluginName[m
[32m+[m[32m                                    plugin = $pluginName[m
                                     file = $cfcFile.FullName[m
[32m+[m[32m                                    domain = $domain[m
                                 }[m
                                 [m
                                 # Use the optimized relationship detection from the module[m
