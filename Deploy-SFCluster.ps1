# Variables.
$clusterloc="westus"
$certpwd="q6D7nN%6ck@6" | ConvertTo-SecureString -AsPlainText -Force
$certfolder="c:\Users\nickw\mycertificates\"
$clustername = "hectagonsfcluster"
$vaultname = "hectagonclusterkeyvault"
$vaultgroupname="hectagon-shared"
$subname="$clustername.$clusterloc.cloudapp.azure.com"
$groupname="hectagon-servicefabric"
$secretId="https://hectagonclusterkeyvault.vault.azure.net/secrets/hectagon-servicefabric20171124124609/21df9bde46c14a199038fc417a679b80"

# Create the Service Fabric cluster.
New-AzureRmServiceFabricCluster -ResourceGroupName $groupname -TemplateFile 'C:\Users\nickw\source\repos\hectagon-servicefabric-infra\cluster.json' -ParameterFile 'C:\Users\nickw\source\repos\hectagon-servicefabric-infra\cluster.parameters.json' -SecretIdentifier $secretId

# To create a new cluster with a new certificate:
# New-AzureRmServiceFabricCluster -ResourceGroupName $groupname -TemplateFile 'C:\Users\nickw\source\repos\hectagon-servicefabric-infra\cluster.json' -ParameterFile 'C:\Users\nickw\source\repos\hectagon-servicefabric-infra\cluster.parameters.json' -CertificatePassword $certpwd -CertificateOutputFolder $certfolder -KeyVaultName $vaultname -KeyVaultResouceGroupName $vaultgroupname -CertificateSubjectName $subname
# Import-PfxCertificate -Exportable -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\Users\nickw\mycertificates\mysfcluster20170531104310.pfx -Password $certpwd

Connect-ServiceFabricCluster -ConnectionEndpoint hectagonsfcluster.westus.cloudapp.azure.com:19000 -KeepAliveIntervalInSec 10 -X509Credential -ServerCertThumbprint F9C4BB1C7B74F60700DAD0A4F1909F83A1535B68 -FindType FindByThumbprint -FindValue F9C4BB1C7B74F60700DAD0A4F1909F83A1535B68 -StoreLocation CurrentUser -StoreName My

Get-ServiceFabricClusterHealth
