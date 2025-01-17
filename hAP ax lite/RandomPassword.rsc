:global GlobalConfig;
:if ($GlobalConfig != true) do={ /system/script/run GlobalConfig;};
:global BotID;
:global ChatID;
:global thisbox;

:local pwdLength (5);
:local GuestProfile ("Guest");
:local PasswordPrefix ("G@");

:local RandomString [:rndstr length=$pwdLength from="0123456789abcdefghijkmnopqrstuvwxyz"]
:local password ("");
:set password ($PasswordPrefix . $RandomString);
:log warning ("New Random  Password for $GuestProfile  $password");
:global thisbox [/system identity get name];
:local hotspotip [/ip/hotspot/get number=0 ip-of-dns-name];
:local urlqr ("");
:set urlqr ("https%3A%2F%2Fdjatun.com%2Fqr%2F%3Fgen%3Dhttp%3A%2F%2F$hotspotip%2Flogin%3Fusername%3D" . $password);

/tool fetch url="https://api.telegram.org/bot$BotID/sendMessage?chat_id=$ChatID&parse_mode=Markdown&text=*$thisbox* _update_ Password WiFi %C2%BB `$password` %C2%AB $urlqr" keep-result=no;
/ip hotspot user remove [find profile=$GuestProfile];
/ip hotspot user add name=$password password="" profile=$GuestProfile;
