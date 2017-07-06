$here = Split-Path -Parent -Path $MyInvocation.MyCommand.Path
kubectl.exe apply -f $here\server.yaml --record
kubectl.exe apply -f $here\service.yaml --record