{% embed "snipplets/page-header.tpl" with { breadcrumbs: true } %}
    {% block page_header_text %}{{ "Blog" | translate }}{% endblock page_header_text %}
{% endembed %}
<div class="px-2 px-md-3">
    <div class="container-fluid mb-5">
        <section class="blog-page">
            <div class="row">
                {% for post in blog.posts %}
                    <div class="col-md-4 mb-3">
                        {{ component(
                            'blog/blog-post-item', {
                                image_lazy: true,
                                image_lazy_js: true,
                                post_item_classes: {
                                    item: 'item item-product-card',
                                    image_container: '',
                                    image: 'img-absolute img-absolute-centered fade-in',
                                    information: 'item-description',
                                    title: 'item-name mb-2',
                                    summary: 'mb-3 font-small',
                                    read_more: 'btn-link btn-link-underline p-0 d-inline-block ',
                                },
                            }) }}
                    </div>
                {% endfor %}
            </div>
            {% include 'snipplets/grid/pagination.tpl' with {'pages': blog.pages} %}
        </section>
    </div>
</div>

