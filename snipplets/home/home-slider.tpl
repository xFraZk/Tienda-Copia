{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_auto_height_slider = not settings.slider_viewport_height %}
{% set use_smaller_thumbs = (has_auto_height_slider and not has_mobile_slider) or has_mobile_slider %}

{% if not mobile %}
<div class="js-home-main-slider-container {% if not has_main_slider %}hidden{% endif %}">
{% endif %}
<div class="{% if mobile %}js-home-mobile-slider{% else %}js-home-main-slider{% endif %}-visibility {% if has_main_slider and has_mobile_slider %}{% if mobile %}d-md-none{% else %}d-none d-md-block{% endif %}{% elseif not settings.toggle_slider_mobile and mobile %}hidden{% endif %} section-slider{% if has_auto_height_slider %} section-slider-auto{% endif %}">
    <div class="js-home-slider{% if mobile %}-mobile{% endif %} nube-slider-home swiper-container swiper-container-horizontal">
        <div class="swiper-wrapper">
            {% if mobile %}
                {% set slider = settings.slider_mobile %}
            {% else %}
                {% set slider = settings.slider %}
            {% endif %}
            {% for slide in slider %}
                <div class="swiper-slide slide-container">
                    {% if slide.link %}
                        <a href="{{ slide.link | setting_url }}" aria-label="{{ 'Carrusel' | translate }} {{ loop.index }}">
                    {% endif %}
                    {% set has_text =  slide.title or slide.description or slide.button %}
                        <div class="slider-slide">

                            {% set apply_lazy_load = not (loop.first and ((has_main_slider and not has_mobile_slider) or (has_mobile_slider and mobile))) %}

                            {% if apply_lazy_load %}
                                {% set slide_src = slide.image | static_url | settings_image_url('tiny') %}
                            {% else %}
                                {% set slide_src = slide.image | static_url | settings_image_url('xlarge') %}
                            {% endif %}

                            <img 
                                {% if slide.width and slide.height %} width="{{ slide.width }}" height="{{ slide.height }}" {% endif %}
                                src="{{ slide_src }}"
                                {% if apply_lazy_load %}data-{% endif %}srcset="{% if use_smaller_thumbs %}{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w, {% endif %}{{ slide.image | static_url | settings_image_url('xlarge') }} 1400w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w"  
                                class="slider-image {% if settings.slider_animation %}slider-image-animation{% endif %} {% if apply_lazy_load %}swiper-lazy blur-up-big{% endif %} {% if has_auto_height_slider %}position-relative d-block{% endif %}" alt="{{ 'Carrusel' | translate }} {{ loop.index }}"
                            />
                            {% if has_text %}
                                <div class="swiper-text swiper-{{ slide.color }}">  
                                    {% if slide.title %}
                                        <div class="swiper-title{% if has_auto_height_slider and not has_mobile_slider %} swiper-title-small{% endif %}">{{ slide.title }}</div>
                                    {% endif %}
                                    {% if slide.description %}
                                        <div class="swiper-description {% if has_auto_height_slider and not has_mobile_slider %}font-small font-md-normal{% else %}mb-3{% endif %}">{{ slide.description }}</div>
                                    {% endif %}
                                    {% if slide.button and slide.link %}
                                        <div class="btn btn-primary swiper-btn d-inline-block mt-3{% if has_auto_height_slider and not has_mobile_slider %} btn-small btn-small-md{% endif %}">{{ slide.button }}</div>
                                    {% endif %}
                                </div>
                            {% endif %}
                        </div>
                    {% if slide.link %}
                        </a>
                    {% endif %}
                    {% if has_text %}
                        <div class="swiper-overlay"></div>
                    {% endif %}
                </div>
            {% endfor %}
        </div>
        <div class="js-swiper-home-control js-swiper-home-pagination{% if mobile %}-mobile{% endif %} swiper-pagination swiper-pagination-bullets swiper-pagination-white">
            {% if slider | length > 1 and not params.preview %}
                {% for slide in slider %}
                    <span class="swiper-pagination-bullet"></span>
                {% endfor %}
            {% endif %}
        </div>
    </div>
</div>
{% if not mobile %}
</div>
{% endif %}