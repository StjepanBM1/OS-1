
    _top_b:
        cmp bl, 1
        je .home
        cmp bl, 2
        je .home
        cmp bl, 3
        je  .home
        cmp bl, 4
        je .home
        cmp bl, 5
        je .home
        cmp bl, 6
        je .home
        cmp bl, 7
        je .home
        cmp bl, 8
        je .home

        jmp _l_curs

        .home:
            jmp _home_win
