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
 * @author Christian M. Jensen
 * @link http://cmjnisse.github.io/piwikanalyticsjs-prestashop
 * @license http://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
 *}
{extends file="helpers/form/form.tpl"}

{block name="input"}
    {if $input.type == 'html'}
        {if isset($input.html_content)}
            {$input.html_content}
        {else}
            {$input.name}
        {/if}
    {elseif $input.type == 'switch' && $smarty.const._PS_VERSION_|@addcslashes:'\'' < '1.6'}
        {foreach $input.values as $value}
            <input type="radio" name="{$input.name}" id="{$value.id}" value="{$value.value|escape:'html':'UTF-8'}"
                   {if $fields_value[$input.name] == $value.value}checked="checked"{/if}
                   {if isset($input.disabled) && $input.disabled}disabled="disabled"{/if} />
            <label class="t" for="{$value.id}">
                {if isset($input.is_bool) && $input.is_bool == true}
                    {if $value.value == 1}
                        <img src="../img/admin/enabled.gif" alt="{$value.label}" title="{$value.label}" />
                    {else}
                        <img src="../img/admin/disabled.gif" alt="{$value.label}" title="{$value.label}" />
                    {/if}
                {else}
                    {$value.label}
                {/if}
            </label>
            {if isset($input.br) && $input.br}<br />{/if}
            {if isset($value.p) && $value.p}<p>{$value.p}</p>{/if}
        {/foreach}

    {else}
        {$smarty.block.parent}
    {/if}
{/block}