{% set has_page_image = page.name == settings.page_title and "us-picture.jpg" | has_custom_image %}
<div class="container-fluid {% if has_page_image %} ml-0 {% endif %}">
    <div class="row">
        {% if has_page_image %}
            <div class="col-md-6 p-0">
                <section class="category-banner">
                    <img class="lazyautosizes lazyload blur-up-big position-relative w-100 img-border" src="{{ "us-picture.jpg" | static_url | settings_image_url('small')}}" data-srcset='{{ "us-picture.jpg" | static_url | settings_image_url('large') }} 480w, {{ "us-picture.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "us-picture.jpg" | static_url | settings_image_url('original') }} 1024w, {{ "us-picture.jpg" | static_url | settings_image_url('1080p') }} 1920w' data-sizes="auto" />
                </section>
            </div>
        {% endif %}
        <div class="col-md-6 p-0">
            {% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
                {% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
            {% endembed %}
            {# Institutional page  #}
            <div class="section-content-page px-2 px-md-3">
                <div class="px-3 font-weight-light user-content">
                    {{ page.content }}
                </div>
            </div>
        </div>
    </div>
</div>
