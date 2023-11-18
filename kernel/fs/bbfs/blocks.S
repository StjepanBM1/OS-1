
        #
        #   Blocks for OS/1 usage
        #   Cannot be changed, preset.
        #

            /*
                Block structure:
                    first 12 bytes - block name (user def.)
                    4084 bytes - data storage
            */

            .code16
            .section    .data.filesys.blocks

        _block_1:   .fill   4096,1,1        # 0xAC00
        _block_2:   .fill   4096,1,2        # 0xBC00
        _block_3:   .fill   4096,1,3        # 0xCC00
        _block_4:   .fill   4096,1,4        # 0xDC00
        _block_5:   .fill   4096,1,5        # 0xEC00
