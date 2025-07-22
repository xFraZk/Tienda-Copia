{% set has_multiple_slides = product.images_count > 1 or product.video_url %}

{% if product.images_count > 0 %}
    <div class="js-swiper-product product-detail-slider swiper-container" style="visibility:hidden; height:0;">
        {% include 'snipplets/labels.tpl' with {'product_detail': true} %}
        <div class="js-product-detail-back product-detail-back d-md-none d-inline-block">
            {% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline icon-2x svg-icon-invert mr-1"} %}
        </div>
        <div class="swiper-wrapper">
            {% for image in product.images %}
             <div class="js-product-slide swiper-slide slider-slide product-slide" data-image="{{image.id}}" data-image-position="{{loop.index0}}">
                <a href="{{ image | product_image_url('original') }}" data-fancybox="product-gallery" class="d-block p-relative" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
                    <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w, {{  image | product_image_url('original') }} 1024w' data-sizes="auto" class="js-product-slide-img product-slider-image img-absolute img-absolute-centered lazyautosizes lazyload" {% if image.alt %}alt="{{image.alt}}"{% endif %}/>
                    <img src="{{ image | product_image_url('tiny') }}" class="js-product-slide-img product-slider-image img-absolute img-absolute-centered blur-up" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
                </a>
             </div>
            {% endfor %}
            {% include 'snipplets/product/product-video.tpl' %}
        </div>
        <div class="js-swiper-product-pagination swiper-pagination swiper-pagination-white d-md-none"></div>
    </div>
    {% snipplet 'placeholders/product-detail-image-placeholder.tpl' %}
{% endif %}
