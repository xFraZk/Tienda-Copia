{# /*============================================================================
  #Page header
==============================================================================*/

#Properties

#Title

#Breadcrumbs

#}

<section class="page-header {% if template == 'account.orders' %} page-header-invert container-invert{% endif %}{% if template == 'account.order'or template == 'account.orders'%} mb-0 {% endif %}{% if template == 'category' and (category.images is not empty or "banner-products.jpg" | has_custom_image) %} page-header-negative {% endif %} {% if template == 'product' %}m-0{% if settings.positive_color_background %}  section-transparent{% endif %}{% else %}px-2 px-md-3{% endif %}" {% if template != 'product' %}data-store="page-title"{% endif %}>
    {% if template == 'blog-post' %}
        <div class="container container-narrow">
    {% elseif template != 'product' %}
        <div class="container-fluid">
    {% endif %}
    {% if template != 'product' or template == 'blog-post' %}
        <div class="row">
    {% endif %}
            <div class="{% if template == 'product' %}mt-2 mt-md-5{% else %}col text-left mt-md-3 mt-4{% endif %}">
                {% include 'snipplets/breadcrumbs.tpl' %}
                <h1 {% if template == 'product' %}class="js-product-name" data-store="product-name-{{ product.id }}"{% endif %} >{% block page_header_text %}{% endblock %}</h1>
                {% if template == 'category' and category.description %}
                    <p class="page-header-text text-left">{{ category.description }}</p>
                {% endif %}
            </div>
    {% if template != 'product' or template == 'blog-post' %}
        </div>
    </div>
    {% endif %}
</section>
