# YDOIALWAYZ4GET

## (NEO)VIM

### (N)Vim bomp command output to buffer

```vim
:redir @"
:<DO COMMANDS HERE>
:redir END
:enew|put
```

## ln -s from .ssh in dotfiles

```bash
lsd -I $HOME'/.ssh/*.secret' --icon never -1 \
| xargs realpath \
| xargs -J % ln -s -- % $HOME/.ssh/
```

## WordPress

### WooCommerce - DELETE all orders before date (NON-HPOS)

```sql
DELETE wp_posts, wp_postmeta, wp_woocommerce_order_items, wp_woocommerce_order_itemmeta
    FROM wp_posts 
    LEFT JOIN wp_postmeta 
        ON wp_posts.ID = wp_postmeta.post_id 
    LEFT JOIN wp_woocommerce_order_itemmeta 
        ON wp_postmeta.post_id = wp_woocommerce_order_itemmeta.order_item_id 
    LEFT JOIN wp_woocommerce_order_items 
        ON wp_posts.ID = wp_woocommerce_order_items.order_item_id 
    WHERE wp_posts.post_type = "shop_order" 
        AND wp_posts.post_date < '2024-11-01';
```

## Docker

### Docker vmnet issue

- [https://github.com/docker/for-mac/issues/6677](https://github.com/docker/for-mac/issues/6677)
