{*
* Copyright (C) 2015 Christian Jensen
*
* This file is part of PiwikAnalyticsJS for prestashop.
* 
* PiwikAnalyticsJS for prestashop is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* PiwikAnalyticsJS for prestashop is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License
* along with PiwikAnalyticsJS for prestashop.  If not, see <http://www.gnu.org/licenses/>.
*
*
* @link http://cmjnisse.github.io/piwikanalyticsjs-prestashop
* @license http://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
*}
<script type="text/javascript">
    var idPKSiteId = '{$psl_CPREFIX}SITEID';
    var idPKToken = '{$psl_CPREFIX}TOKEN_AUTH';
    var htmls000 = "<div><a href=\"#close\" onclick=\"PiwikLookup();\" title=\"{l s='Close' mod='piwikanalyticsjs'}\" class=\"PiwikLookupClose\">X</a>";
    htmls000 += "<h2>Piwik credentials</h2>";
    htmls000 += "<p>{l s='Enter username and password of your piwik login, wee need this to get your api key (auth token)' mod='piwikanalyticsjs'}</p>";
    htmls000 += "<form id=\"PiwikLookupLoginForm\" action=\"POST\" onsubmit=\"return PiwikLookupLogin();\"><p>";
    htmls000 += "<label for=\"PiwikLookupLoginFormUsername\" style=\"width: 100%; text-align: left;\">{l s='Username:' mod='piwikanalyticsjs'}</label>";
    htmls000 += "<input id=\"PiwikLookupLoginFormUsername\" type=\"TEXT\" style=\"height: 25px; width: 386px;\"/>";
    htmls000 += "</p><p>";
    htmls000 += "<label for=\"PiwikLookupLoginFormPassword\" style=\"width: 100%; text-align: left;\">{l s='Password:' mod='piwikanalyticsjs'}</label>";
    htmls000 += "<input id=\"PiwikLookupLoginFormPassword\" type=\"PASSWORD\" style=\"height: 25px; width: 386px;\"/>";
    htmls000 += "</p><p>";
    
    htmls000 += "<label for=\"PiwikLookupLoginFormHttpAuthSettings\" style=\"width: 100%; text-align: left;\">";
    htmls000 += "<input id=\"PiwikLookupLoginFormHttpAuthSettings\" type=\"CHECKBOX\" onclick='if(this.checked) { $(\"#PiwikLookupLoginFormHttpAuthSettingsWraper\").show(); } else { $(\"#PiwikLookupLoginFormHttpAuthSettingsWraper\").hide(); }'/>";
    htmls000 += "{l s='HTTP Basic Authorization?' mod='piwikanalyticsjs'}";
    htmls000 += "</label><br/>";
    htmls000 += "</p><div id=\"PiwikLookupLoginFormHttpAuthSettingsWraper\" style=\"display:none;\">";
    
    htmls000 += "<label for=\"PiwikLookupLoginFormHttpAuthUsername\" style=\"width: 100%; text-align: left;\">{l s='HTTP Authorization Username:' mod='piwikanalyticsjs'}</label>";
    htmls000 += "<input id=\"PiwikLookupLoginFormHttpAuthUsername\" type=\"TEXT\" style=\"height: 25px; width: 386px;\"/>";
    htmls000 += "</p><p>";
    htmls000 += "<label for=\"PiwikLookupLoginFormHttpAuthPassword\" style=\"width: 100%; text-align: left;\">{l s='HTTP Authorization Password:' mod='piwikanalyticsjs'}</label>";
    htmls000 += "<input id=\"PiwikLookupLoginFormHttpAuthPassword\" type=\"PASSWORD\" style=\"height: 25px; width: 386px;\"/>";
    htmls000 += "</p><p>";

    htmls000 += "</div><p>";
    htmls000 += "<input type=\"SUBMIT\" value=\"{l s='Login' mod='piwikanalyticsjs'}\" />";
    htmls000 += "</p></form></div>";
    var htmls001 = '<a id="LookupSITEID" onclick="return PiwikLookup();" style="font-weight: bold; font-style: italic; color: rgb(88, 90, 105); font-size: 110%;" href="#">{l s="Fetch from Piwik" mod='piwikanalyticsjs'}</a>';
    var htmls002 = '<a id="LookupTOKEN_AUTH" onclick="return PiwikLookup();" style="font-weight: bold; font-style: italic; color: rgb(88, 90, 105); font-size: 110%;" href="#">{l s="Fetch from Piwik" mod='piwikanalyticsjs'}</a>';
    $(document).ready(function(){
        if (($('#' + idPKSiteId).val() === '') || ($('#' + idPKSiteId).val() === '0') || (parseInt($('#' + idPKSiteId).val()) <= 0)){
            $('#' + idPKSiteId).parent().find("sup").after(htmls001);
        }
        if ($('#' + idPKToken).val() === ''){
            $('#' + idPKToken).parent().find("sup").after(htmls002);
        }
        $('#PiwikLookupModal').html(htmls000);
        
    });
    var _upPopO = false;
    function PiwikLookup(){
        $('#PiwikLookupModal').html(htmls000);
        if(_upPopO){
            _upPopO = false;
            $('#PiwikLookupModal').css( { opacity:0, 'pointer-events':'none' } );
        } else {
            _upPopO = true;
            $('#PiwikLookupModal').css( { opacity:1, 'pointer-events':'auto' } );
        }
        return false;
    }
    function PiwikLookupLogin(){
        var username = $('#PiwikLookupLoginFormUsername').val(),
                password = $('#PiwikLookupLoginFormPassword').val(),
                http_username = $('#PiwikLookupLoginFormHttpAuthUsername').val(),
                http_password = $('#PiwikLookupLoginFormHttpAuthPassword').val(),
                authtoken = '', piwikhost = '';
        
        if(http_username === "" || http_username === false)
            http_username = $('#PIWIK_PAUTHUSR').val();
        if(http_password === "" || http_password === false)
            http_password = $('#PIWIK_PAUTHPWD').val();
        {* Http auth *}
        $('#PIWIK_PAUTHUSR').val(http_username);
        $('#PIWIK_PAUTHPWD').val(http_password);
        {* Piwik login *}
        $('#PIWIK_USRNAME').val(username);
        $('#PIWIK_USRPASSWD').val(password);
        
        piwikhost = prompt('{l s='Please enter piwik host' mod='piwikanalyticsjs'}', ($('#PIWIK_HOST').val().trim()==='' ? 'piwik.example.com/piwik2/' : $('#PIWIK_HOST').val().trim()));
		piwikhost = piwikhost.replace("http://", "").replace("https://", "").replace("://", "").replace("//", ""); 
        $('#PIWIK_HOST').val(piwikhost);
		
        /* get auth token */
        $.ajax({
            type: 'POST',
            url: '{$psl_currentIndex}&token={$psl_token}',
            /*
             url: 'http://' + piwikhost + 'index.php?module=API&method=UsersManager.getTokenAuth&userLogin='+username+'&md5Password='+password+'&format=JSON'
             */
            dataType: 'json',
            data: {
                'pkapicall': 'getTokenAuth',
                'userLogin': username,
                'password': password,
                'httpUser': http_username,
                'httpPasswd': http_password,
                'piwikhost': piwikhost
            },
            success: function(data) {
                if (data.error === true){
                    jAlert(data.message);
                } else {
                    authtoken = data.message;
                    $('#PIWIK_TOKEN_AUTH').val(authtoken);
                    $.ajax({
                        type: 'POST',
                        url: 'http://' + piwikhost + 'index.php?module=API&token_auth=' + authtoken + '&method=SitesManager.getSitesWithAdminAccess&format=JSON',
                        dataType: 'json',
                        success: function(data) {
                            if (data.error === true){
                                jAlert(data.message);
                                PiwikLookup();
                            } else {
                                var siteshtml = "";
                                for (var i = 0, max = data.length; i < max; i++) {
                                    siteshtml += "<li style='cursor: pointer; color: black;' onclick='PiwikLookupSetSiteId(" + data[i].idsite + ");'>" + data[i].name + " #" + data[i].idsite + "</li>";
                                }
                                var html = [
                                    '<style>.tyujhgfdc li:hover{ background-color:#EEEEEE; }</style>',
                                    '<div><a href="#close" onclick="PiwikLookup();" title="{l s='Close' mod='piwikanalyticsjs'}" class="PiwikLookupClose">X</a>',
                                    '<h2>{l s='Select the site you are setting up.' mod='piwikanalyticsjs'}</h2>',
                                    '<p><ul class="tyujhgfdc">' + siteshtml + '</ul>',
                                    '</p></div>',
                                ];
                                $("#PiwikLookupModal").html(html.join(""));
                            }
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown){
                            jAlert("Error while fetching Piwik Data\n\ntextStatus: " + textStatus + "\nerrorThrown: '" + errorThrown + "\nresponseText:\n" + XMLHttpRequest.responseText);
                        },
                    });
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                jAlert("Error while fetching Piwik Data\n\ntextStatus: " + textStatus + "\nerrorThrown: " + errorThrown + "\nresponseText:\n" + XMLHttpRequest.responseText);
            },
        });
        return false;
    }
    function PiwikLookupSetSiteId(id){
        $('#PIWIK_SITEID').val(id);
        PiwikLookup();
        if($('#_form_submit_btn').length > 0)
            $('#_form_submit_btn').click();
        if($('#configuration_form_submit_btn').length > 0)
            $('#configuration_form_submit_btn').click();
    }
    
</script>
    
<style type="text/css">
    .PiwikLookupModalDialog { position:fixed;font-family:Arial,Helvetica,sans-serif;top:0;right:0;bottom:0;left:0;background:rgba(0,0,0,.8);z-index:99999;opacity:0;-webkit-transition:opacity 400ms ease-in;-moz-transition:opacity 400ms ease-in;transition:opacity 400ms ease-in;pointer-events:none } 
    {* .PiwikLookupModalDialog:target { opacity:1;pointer-events:auto } *}
    .PiwikLookupModalDialog>div { width:400px;position:relative;margin:35px auto;padding:5px 20px 13px 20px;border-radius:10px;background:#fff;background:-moz-linear-gradient(#fff,#DDD);background:-webkit-linear-gradient(#fff,#DDD);background:-o-linear-gradient(#fff,#DDD)}
    .PiwikLookupClose { background:#606061;color:#fff;line-height:25px;position:absolute;right:0px;text-align:center;top:0px;width:24px;text-decoration:none;font-weight:bold;-webkit-border-radius:8px;-moz-border-radius:8px;border-radius:8px;-moz-box-shadow:1px 1px 3px #000;-webkit-box-shadow:1px 1px 3px #000;box-shadow:1px 1px 3px #000 }
    .PiwikLookupClose:hover { background:#00d9ff }
</style>
{* <a href="#PiwikLookupModal"onclick="PiwikLookup();">Open Modal 2</a> *}
<div id="PiwikLookupModal" class="PiwikLookupModalDialog"></div>