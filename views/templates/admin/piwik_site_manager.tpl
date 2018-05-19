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
    function submitPiwikSiteAPIUpdate() {
        var idSite = $('#PKAdminIdSite').val();
        var siteName = $('#PKAdminSiteName').val();
        /*var urls = $('#PKAdminSiteUrls').val();*/
        var ecommerce = $('input[name=PKAdminEcommerce]:checked').val();
        var siteSearch = $('input[name=PKAdminSiteSearch]:checked').val();
        if ( $.isFunction($.fn.tagify) )
            $(this).find('#PKAdminSearchKeywordParameters').val($('#PKAdminSearchKeywordParameters').tagify('serialize'));
        var searchKeywordParameters = $('#PKAdminSearchKeywordParameters').val();
        if ( $.isFunction($.fn.tagify) )
            $(this).find('#PKAdminSearchCategoryParameters').val($('#PKAdminSearchCategoryParameters').tagify('serialize'));
        var searchCategoryParameters = $('#PKAdminSearchCategoryParameters').val();
        if ( $.isFunction($.fn.tagify) )
            $(this).find('#PKAdminExcludedIps').val($('#PKAdminExcludedIps').tagify('serialize'));
        var excludedIps = $('#PKAdminExcludedIps').val();
        if ( $.isFunction($.fn.tagify) )
            $(this).find('#PKAdminExcludedQueryParameters').val($('#PKAdminExcludedQueryParameters').tagify('serialize'));
        var excludedQueryParameters = $('#PKAdminExcludedQueryParameters').val();
        var timezone = $('#PKAdminTimezone').val();
        var currency = $('#PKAdminCurrency').val();
        /*var group = $('#PKAdminGroup').val();*/
        /*var startDate = $('#PKAdminStartDate').val();*/
        var excludedUserAgents = $('#PKAdminExcludedUserAgents').val();
        var keepURLFragments = $('input[name=PKAdminKeepURLFragments]:checked').val();
        /*var type = $('#PKAdminSiteType').val();*/
        $.ajax( {
            type: 'POST',
            url: '{$psm_currentIndex}&token={$psm_token}',
            dataType: 'json',
            data: {
                'pkapicall': 'updatePiwikSite',
                'ajax': 1,
                'idSite': idSite,
                'siteName': siteName,
                'ecommerce': ecommerce,
                'siteSearch': siteSearch,
                'searchKeywordParameters': searchKeywordParameters,
                'searchCategoryParameters': searchCategoryParameters,
                'excludedIps': excludedIps,
                'excludedQueryParameters': excludedQueryParameters,
                'timezone': timezone,
                'currency': currency,
                'keepURLFragments': keepURLFragments,
                /*'group': group, */
                'excludedUserAgents': excludedUserAgents,
            },
            beforeSend: function(){
                showLoadingStuff();
            },
            success: function(data) {
                jAlert(data.message);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                jAlert("Error while saving Piwik Data\n\ntextStatus: '" + textStatus + "'\nerrorThrown: '" + errorThrown + "'\nresponseText:\n" + XMLHttpRequest.responseText);
        },
        complete: function(){
            hideLoadingStuff();
        }
    });
    
        return false;
    }
    {if version_compare($psversion, '1.5.4.999','>')}
    function hideLoadingStuff() { 
        $('#ajax_running').hide('fast'); 
        clearTimeout(ajax_running_timeout); 
        $.fancybox.helpers.overlay.close(); 
        $.fancybox.hideLoading(); 
    }
    function showLoadingStuff() {
        showAjaxOverlay();
        $.fancybox.helpers.overlay.open({ parent: $('body') });
        $.fancybox.showLoading();
    }
    {else}
    function showLoadingStuff() { $.fancybox.showActivity(); };
    function hideLoadingStuff() { $.fancybox.hideActivity(); };
    {/if}
    function ChangePKSiteEdit(id){
        $.ajax( { 
            type: 'POST',
            url: '{$psm_currentIndex}&token={$psm_token}',
            dataType: 'json',
            data: {
                'pkapicall': 'getPiwikSite',
                'idSite': id,
            },
            beforeSend: function(){
                showLoadingStuff();
            },
            success: function(data) {
                /* $('#SPKSID').val(data.message[0].idSite);  */
                $('#PKAdminIdSite').val(data.message[0].idsite);
                $('#PKAdminSiteName').val(data.message[0].name);
                $('#wnamedsting').text(data.message[0].name);
                /*$('#PKAdminSiteUrls').val(data.message[0].main_url);*/
                {if $psversion >= '1.6'}
                        if(data.message[0].ecommerce === 1){
                            $('#PKAdminEcommerce_on').prop('checked', true);
                            $('#PKAdminEcommerce_off').prop('checked', false);
                        } else {
                            $('#PKAdminEcommerce_off').prop('checked', true);
                            $('#PKAdminEcommerce_on').prop('checked', false);
                        } 
                        if(data.message[0].sitesearch === 1){ 
                            $('#PKAdminSiteSearch_on').prop('checked', true);
                            $('#PKAdminSiteSearch_off').prop('checked', false);
                        } else {
                            $('#PKAdminSiteSearch_off').prop('checked', true);
                            $('#PKAdminSiteSearch_on').prop('checked', false);
                        }
                {else}
                    if(data.message[0].ecommerce === 1){
                        $('input[id=active_on][name=PKAdminEcommerce]').attr('checked', true);
                        $('input[id=active_off][name=PKAdminEcommerce]').attr('checked', false);
                    } else {
                        $('input[id=active_off][name=PKAdminEcommerce]').attr('checked', true);
                        $('input[id=active_on][name=PKAdminEcommerce]').attr('checked', false);
                    }
                    if(data.message[0].sitesearch === 1){
                        $('input[id=active_on][name=PKAdminSiteSearch]').attr('checked', true);
                        $('input[id=active_off][name=PKAdminSiteSearch]').attr('checked', false);
                    } else {
                        $('input[id=active_off][name=PKAdminSiteSearch]').attr('checked', true);
                        $('input[id=active_on][name=PKAdminSiteSearch]').attr('checked', false);
                    }
                {/if}
                $('#PKAdminSearchKeywordParameters').val(data.message[0].sitesearch_keyword_parameters);
                $('#PKAdminSearchCategoryParameters').val(data.message[0].sitesearch_category_parameters);
                $('#PKAdminExcludedIps').val(data.message[0].excluded_ips);
                $('#PKAdminExcludedQueryParameters').val(data.message[0].excluded_parameters);
                $('#PKAdminTimezone').val(data.message[0].timezone);
                $('#PKAdminCurrency').val(data.message[0].currency);
                /*$('#PKAdminGroup').val(data.message[0].group);*/
                /*$('#PKAdminStartDate').val(data.message[0].ts_created);*/
                $('#PKAdminExcludedUserAgents').val(data.message[0].excluded_user_agents);
                
                {if $psversion >= '1.6'}
                    if(data.message[0].keep_url_fragment===1){
                        $('#PKAdminKeepURLFragments_on').prop('checked', true);
                        $('#PKAdminKeepURLFragments_off').prop('checked', false);
                    } else {
                        $('#PKAdminKeepURLFragments_off').prop('checked', true);
                        $('#PKAdminKeepURLFragments_on').prop('checked', false);
                    }
                {else}
                    if(data.message[0].keep_url_fragment===1){
                        $('input[id=active_on][name=PKAdminKeepURLFragments]').attr('checked', true);
                        $('input[id=active_off][name=PKAdminKeepURLFragments]').attr('checked', false);
                    } else {
                        $('input[id=active_off][name=PKAdminKeepURLFragments]').attr('checked', true);
                        $('input[id=active_on][name=PKAdminKeepURLFragments]').attr('checked', false);
                    }
                {/if}
                /*$('#PKAdminSiteType').val(data.message[0].type);*/
            },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                jAlert("Error while saving Piwik Data\n\ntextStatus: '" + textStatus + "'\nerrorThrown: '" + errorThrown + "'\nresponseText:\n" + XMLHttpRequest.responseText);
            },
            complete: function(){
                hideLoadingStuff();
            }
        });
    }
</script>