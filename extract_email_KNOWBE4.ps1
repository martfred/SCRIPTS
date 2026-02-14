# Extraction des membres pour les groupes KnowBe4
$file = "C:\Users\martin.fredette\OneDrive - Cima+\CIMA+\PowerBI\Donnees\KnowBe4.csv"
Remove-Item $file -force

$GroupNames = @("000-00-USAGERFR", "000-00-USAGEREN", "000-00-SEC-KNOWBE4-FR", "000-00-SEC-KNOWBE4-EN", "000-00-SEC-KB4-ONBOARD-EN-COMPLETED", "000-00-SEC-KB4-ONBOARD-FR-COMPLETED", "000-00-SEC-KNOWBE4-EXCLUDE")

$GroupNames | ForEach-Object {
    $grlist1 = Get-ADGroup -Identity $_ | select-object name

    foreach ($gr1 in $grlist1)
    {
        $mem = Get-ADGroupMember -identity $gr1.name
        foreach ($user1 in $mem)
        {
                $mail1 =  Get-ADUser $user1 -Properties * | Where { $_.Enabled -eq $True } | select-object *
                
                foreach ($user in $mail1)
                {  
                    $out = $user.UserPrincipalName + "|" + $gr1.name
                    out-file -InputObject $out -FilePath $file -append
                }
        }
    }
}