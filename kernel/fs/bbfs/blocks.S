
        #
        #   Blocks for OS/1 usage
        #   Cannot be changed, preset.
        #
        #   As of v5.4.0 this file is
        #   useless as no application
        #   uses these blocks
        #

            /*
                Block structure:
                    first 12 bytes - block name (user def.)
                    500 bytes - data storage
            */

            .code16
            .section    .blocks
        _block_1:   .fill   512,1,1        # 0xAC00
        _block_2:   .fill   512,1,2        # 0xAE00
        _block_3:   .fill   512,1,3        # 0xB000
        _block_4:   .fill   512,1,4        # 0xB200
        _block_5:   .fill   512,1,5        # 0xB400
