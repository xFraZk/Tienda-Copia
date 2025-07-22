{# Payments details #}
<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container position-relative" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="container-fluid p-0">
        <div class="section-single-product row no-gutters mb-md-4">
            <div class="col-md-7" data-store="product-image-{{ product.id }}">
                {% include 'snipplets/product/product-image.tpl' %}
            </div>
            <div class="col-md-5" data-store="product-info-{{ product.id }}">
                {% include 'snipplets/product/product-form.tpl' %}
            </div>
        </div>
        <div id="reviewsapp"></div>
    </div>  
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}
