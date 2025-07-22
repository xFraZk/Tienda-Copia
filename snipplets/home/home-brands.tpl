{% if settings.brands and settings.brands is not empty %} 
    <section class="section-brands-home px-2 px-md-3" data-store="home-brands">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    {% if settings.brands_description %}
                        <div class="mb-3 label-title font-smallest font-weight-light">{{ settings.brands_description }}</div>
                    {% endif %}
                    {% if settings.brands_title %}
                        <div class="h1 mb-4">{{ settings.brands_title }}</div>
                    {% endif %}
                </div>
                <div class="col-md-6">
                    <div class="js-swiper-brands swiper-container mb-4 text-center">
                        <div class="swiper-wrapper">
                            {% for slide in settings.brands %}
                                <div class="swiper-slide slide-container brand-image-container">
                                    {% if slide.link %}
                                        <a href="{{ slide.link | setting_url }}" title="{{ 'Marca {1} de' | translate(loop.index) }} {{ store.name }}" aria-label="{{ 'Marca {1} de' | translate(loop.index) }} {{ store.name }}">
                                    {% endif %}
                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('large') }}" class="lazyload brand-image" alt="{{ 'Marca {1} de' | translate(loop.index) }} {{ store.name }}">
                                    {% if slide.link %}
                                        </a>
                                    {% endif %}
                                </div>
                            {% endfor %}
                        </div>
                    </div>
                    <div class="d-block d-md-none">
                        <div class="js-swiper-brands-pagination swiper-pagination swiper-pagination-bullets swiper-pagination-white p-0"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="js-swiper-brands-prev swiper-button-prev d-none d-md-block mt-4">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline icon-2x svg-icon-invert"} %}</div>
        <div class="js-swiper-brands-next swiper-button-next d-none d-md-block mt-4">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline icon-2x svg-icon-invert"} %}</div>
    </section>
{% endif %}
