{% embed "snipplets/page-header.tpl" with { breadcrumbs: false } %}
    {% block page_header_text %}{{ category.name }}{% endblock page_header_text %}
{% endembed %}
<section class="category-body px-2 px-md-3">
    <div class="container-fluid">
        <div class="row">
            <div class="col">
                <div class="js-product-table row">
                    {% include 'snipplets/defaults/help_item.tpl' with {'help_item_1': true} %}
                    {% include 'snipplets/defaults/help_item.tpl' with {'help_item_2': true} %}
                    {% include 'snipplets/defaults/help_item.tpl' with {'help_item_3': true} %}
                    {% include 'snipplets/defaults/help_item.tpl' with {'help_item_4': true} %}
                    {% include 'snipplets/defaults/help_item.tpl' with {'help_item_5': true} %}
                    {% include 'snipplets/defaults/help_item.tpl' with {'help_item_6': true} %}
                    {% include 'snipplets/defaults/help_item.tpl' with {'help_item_7': true} %}
                    {% include 'snipplets/defaults/help_item.tpl' with {'help_item_8': true} %}
                    {% include 'snipplets/defaults/help_item.tpl' with {'help_item_1': true} %}
                </div>
            </div>
        </div>
    </div>
</section>