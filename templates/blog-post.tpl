{% embed "snipplets/page-header.tpl" with { breadcrumbs: true, page_header_title_class: 'mb-0' } %}
    {% block page_header_text %}{{ post.title }}{% endblock page_header_text %}
{% endembed %}
<div class="container container-narrow">
    <div class="blog-post-page pb-5">
        {{ component(
            'blog/blog-post-content', {
                image_lazy: true,
                image_lazy_js: true,
                post_content_classes: {
                    date: 'mb-3 font-small',
                    image: 'img-fluid fade-in mb-4',
                    content: 'mb-2',
                },
            })
        }}
    </div>
</div>
