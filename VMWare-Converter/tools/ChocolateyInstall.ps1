﻿$arguments = @{
    file       = 'VMware-converter-en-6.1.1-3533064.exe'
    checksum   = '07B73D49AF6E8B38ABAAB135EA9F23A60B92904815BC7F09BB9148DB66E1EFFC'
    silentArgs = '/S /v/qn'
}

Install-Package $arguments
