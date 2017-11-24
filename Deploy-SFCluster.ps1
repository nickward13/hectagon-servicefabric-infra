# Variables.
$clusterloc="westus"
$certpwd="q6D7nN%6ck@6" | ConvertTo-SecureString -AsPlainText -Force
$certfolder="c:\Users\nickw\mycertificates\"
$clustername = "hectagonsfcluster"
$vaultname = "hectagonclusterkeyvault"
$vaultgroupname="hectagon-shared"
$subname="$clustername.$clusterloc.cloudapp.azure.com"
$groupname="hectagon-servicefabric"

# Create the Service Fabric cluster.
New-AzureRmServiceFabricCluster  -ResourceGroupName $groupname -TemplateFile 'C:\Users\nickw\source\repos\hectagon-servicefabric-infra\cluster.json' -ParameterFile 'C:\Users\nickw\source\repos\hectagon-servicefabric-infra\cluster.parameters.json' -CertificatePassword $certpwd -CertificateOutputFolder $certfolder -KeyVaultName $vaultname -KeyVaultResouceGroupName $vaultgroupname -CertificateSubjectName $subname

