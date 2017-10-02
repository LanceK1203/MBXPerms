# MBXPerms
# Script to add mailbox perms


<#
Script to assign mailbox permissions. 

Give one or more users FullAccess to one or more mailboxes
Give one or more users Send as rights to one or more mailboxes
Give one or more users FullAccess and Send as rights to one or more mailboxes

#>


[CmdletBinding()]

param(
       
        $automap       

)




Write-Host "1. " -NoNewLine -ForegroundColor Yellow
Write-Host "Assign FullAccess and SendAs"

Write-Host "2. " -NoNewLine -ForegroundColor Yellow
Write-Host "Assign FullAccess only"

Write-Host "3. " -NoNewline -ForegroundColor Yellow
Write-Host "Assign SendAs only"

$menuselect = Read-Host

Switch ($menuselect)
    { 
        "1"

            {       

                write-host "Please enter the users that need FullAccess and SendAs: " -NoNewline -ForegroundColor Green

                $user = Read-Host 
                $multipleusers = $user.Split(",")

                Write-Host "Please enter the mailboxes to give access to: " -NoNewline -ForegroundColor Green

                $mbs = Read-Host
                $multiplembs = $mbs.split(",") 

                Write-Host "Do you want to enable AutoMapping?" -NoNewline -ForegroundColor Green 
                Write-Host "(true/false): " -NoNewline 
                $automap = Read-Host

               
    
                    if ($automap -eq $true)
                    {
                            foreach($mluser in $multipleusers)
                            {
                                 foreach($mb in $multiplembs) 
                                       {
                                        Write-Host "setting fullaccess on $mb WITH AUTOMAPPING"
                                        Add-365MailboxPermission -Identity $mb -User $mluser -AccessRights fullaccess -AutoMapping $true -WhatIf #comment out the whatif when ready
                                        Write-Host "setting send as on $mb"
                                        Add-365RecipientPermission -Identity $mb -Trustee $mluser -AccessRights sendas -Confirm:$false -WhatIf #comment out the whatif when ready
                                        }
                             }
                    }
                    else
                         {

                             foreach($mluser in $multipleusers)
                            {
                                  foreach($mb in $multiplembs) 
                                      {
                                        Write-Host "setting fullaccess on $mb WITHOUT AUTOMAPPING"
                                        Add-365MailboxPermission -Identity $mb -User $mluser -AccessRights fullaccess -AutoMapping $false -WhatIf #comment out the whatif when ready
                                        Write-Host "setting send as on $mb"
                                        Add-365RecipientPermission -Identity $mb -Trustee $mluser -AccessRights sendas -Confirm:$false -WhatIf #comment out the whatif when ready
                                      }
                         }
                    
                 }   
            }

        "2"

            {
            
            write-host "Please enter the users that need FullAccess only: " -NoNewline -ForegroundColor Green

                $user = Read-Host 
                $multipleusers = $user.Split(",")

                Write-Host "Please enter the mailboxes to give access to: " -NoNewline -ForegroundColor Green

              $mbs = Read-Host
              $multiplembs = $mbs.split(",") 

                Write-Host "Do you want to enable AutoMapping?" -NoNewline -ForegroundColor Green 
                Write-Host "(true/false): " -NoNewline 
                $automap = Read-Host
                
                    if ($automap -eq $true)
                    {
                            foreach($mluser in $multipleusers)
                            {
                                 foreach($mb in $multiplembs) 
                                       {
                                        Write-Host "setting fullaccess on $mb WITH AUTOMAPPING"
                                        Add-365MailboxPermission -Identity $mb -User $mluser -AccessRights fullaccess -AutoMapping $true -WhatIf #comment out the whatif when ready
                                        }
                                }
                    }
                    else
                         {
                              foreach($mluser in $multipleusers)
                              {   
                                  foreach($mb in $multiplembs) 
                                      {
                                        Write-Host "setting fullaccess on $mb WITHOUT AUTOMAPPING"
                                        Add-365MailboxPermission -Identity $mb -User $mluser -AccessRights fullaccess -AutoMapping $false -WhatIf #comment out the whatif when ready
                                      }
                                }
                         }
            }

        "3"

            {
            
            write-host "Please enter the users that need SendAs access only: " -NoNewline -ForegroundColor Green

                $user = Read-Host 
                $multipleusers = $user.Split(",")

                Write-Host "Please enter the mailboxes to give access to: " -NoNewline -ForegroundColor Green

               $mbs = Read-Host
                $multiplembs = $mbs.split(",") 

                        
                 foreach($mluser in $multipleusers)
                 
                    {    
                        foreach($mb in $multiplembs)
                            {
    
                             Write-Host "setting send as on $mb"
                             Add-365RecipientPermission -Identity $mb -Trustee $user -AccessRights sendas -Confirm:$false -WhatIf #comment out the whatif when ready

                             }
                        }
            
            }

       }
    
