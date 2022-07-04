class CountryConfig
  class << self
    def config
      {
        AL: {
          name: 'Albania',
          code: 'AL',
          bban_format: '8n,16c',
          iban_length: 28,
          branch_code: [7, 11],
          account_number: [12, 28],
          regex: 'AL\d\d\d{8}[a-zA-Z0-9]{16}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'branch_code',
            indexes: [7, 10],
            regex: '\d{4}',
            },
            {
            part: 'checksum',
            indexes: [11, 11],
            regex: '\d{1}',
            },
            {
            part: 'account_number',
            indexes: [12, 27],
            regex: '[a-zA-Z0-9]{16}',
            },
          ]
          },
        AD: {
          name: 'Andorra',
          code: 'AD',
          bban_format: '8n,12c',
          iban_length: 24,
          branch_code: [8, 12],
          account_number: [12, 24],
          regex: 'AD\d\d\d{8}[a-zA-Z0-9]{12}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [12, 23],
            regex: '[a-zA-Z0-9]{12}',
            },
          ]
          },
        AT: {
          name: 'Austria',
          code: 'AT',
          bban_format: '16n',
          iban_length: 20,
          account_number: [9, 20],
          regex: 'AT\d\d\d{16}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 8],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [9, 19],
            regex: '\d{11}',
            },
          ]
          },
        AZ: {
          name: 'Azerbaijan',
          code: 'AZ',
          bban_format: '4c,20n',
          iban_length: 28,
          account_number: [8, 28],
          regex: 'AZ\d\d[a-zA-Z0-9]{4}\d{20}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[a-zA-Z0-9]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 27],
            regex: '\d{20}',
            },
          ]
          },
        BH: {
          name: 'Bahrain',
          code: 'BH',
          bban_format: '4a,14c',
          iban_length: 22,
          account_number: [8, 22],
          regex: 'BH\d\d[A-Z]{4}[a-zA-Z0-9]{14}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 21],
            regex: '[a-zA-Z0-9]{14}',
            },
          ]
          },
        BY: {
          name: 'Belarus',
          code: 'BY',
          bban_format: '4c,4n,16c',
          iban_length: 28,
          account_number: [12, 28],
          balance_account_number: [8, 12],
          regex: 'BY\d\d[a-zA-Z0-9]{4}\d{4}[a-zA-Z0-9]{16}',
          parts: %w[bank_code account_number balance_account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[a-zA-Z0-9]{4}',
            },
            {
            part: 'balance_account_number',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [12, 27],
            regex: '[a-zA-Z0-9]{16}',
            },
          ]
          },
        BE: {
          name: 'Belgium',
          code: 'BE',
          bban_format: '12n',
          iban_length: 16,
          account_number: [7, 14],
          regex: 'BE\d\d\d{12}',
          parts: %w[bank_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 13],
            regex: '\d{7}',
            },
            {
            part: 'checksum',
            indexes: [14, 15],
            regex: '\d{2}',
            },
          ]
          },
        BA: {
          name: 'Bosnia and Herzegovina',
          code: 'BA',
          bban_format: '16n',
          iban_length: 20,
          branch_code: [7, 10],
          account_number: [10, 18],
          regex: 'BA\d\d\d{16}',
          parts: %w[bank_code branch_code checksum account_number],
          const_global_checksum: '39',
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'branch_code',
            indexes: [7, 9],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [10, 17],
            regex: '\d{8}',
            },
            {
            part: 'checksum',
            indexes: [18, 19],
            regex: '\d{2}',
            },
          ]
          },
        BR: {
          name: 'Brazil',
          code: 'BR',
          bban_format: '23n,1a,1c',
          iban_length: 29,
          branch_code: [12, 17],
          account_number: [17, 27],
          account_type: [27, 28],
          owner_account_number: [28, 29],
          regex: 'BR\d\d\d{23}[A-Z]{1}[a-zA-Z0-9]{1}',
          parts: %w[bank_code branch_code account_number account_type owner_account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 11],
            regex: '\d{8}',
            },
            {
            part: 'branch_code',
            indexes: [12, 16],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [17, 26],
            regex: '\d{10}',
            },
            {
            part: 'account_type',
            indexes: [27, 27],
            regex: '[A-Z]{1}',
            },
            {
            part: 'owner_account_number',
            indexes: [28, 28],
            regex: '[a-zA-Z0-9]{1}',
            },
          ]
          },
        BG: {
          name: 'Bulgaria',
          code: 'BG',
          bban_format: '4a,6n,8c',
          iban_length: 22,
          branch_code: [8, 12],
          account_number: [14, 22],
          account_type: [12, 14],
          regex: 'BG\d\d[A-Z]{4}\d{6}[a-zA-Z0-9]{8}',
          parts: %w[bank_code branch_code account_number account_type],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'account_type',
            indexes: [12, 13],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [14, 21],
            regex: '[a-zA-Z0-9]{8}',
            },
          ]
          },
        CR: {
          name: 'Costa Rica',
          code: 'CR',
          bban_format: '18n',
          iban_length: 22,
          account_number: [8, 22],
          zero: [4, 5],
          regex: 'CR\d\d\d{18}',
          parts: %w[bank_code account_number zero],
          parts_in_order: [
            {
            part: 'zero',
            indexes: [4, 4],
            regex: '\d{1}',
            },
            {
            part: 'bank_code',
            indexes: [5, 7],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [8, 21],
            regex: '\d{14}',
            },
          ]
          },
        HR: {
          name: 'Croatia',
          code: 'HR',
          bban_format: '17n',
          iban_length: 21,
          account_number: [11, 21],
          regex: 'HR\d\d\d{17}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 10],
            regex: '\d{7}',
            },
            {
            part: 'account_number',
            indexes: [11, 20],
            regex: '\d{10}',
            },
          ]
          },
        CY: {
          name: 'Cyprus',
          code: 'CY',
          bban_format: '8n,16c',
          iban_length: 28,
          branch_code: [7, 12],
          account_number: [12, 28],
          regex: 'CY\d\d\d{8}[a-zA-Z0-9]{16}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'branch_code',
            indexes: [7, 11],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [12, 27],
            regex: '[a-zA-Z0-9]{16}',
            },
          ]
          },
        CZ: {
          name: 'Czech Republic',
          code: 'CZ',
          bban_format: '20n',
          iban_length: 24,
          branch_code: [12, 14],
          account_number: [14, 24],
          account_prefix: [8, 12],
          regex: 'CZ\d\d\d{20}',
          parts: %w[bank_code branch_code account_number account_prefix],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'account_prefix',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'branch_code',
            indexes: [12, 13],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [14, 23],
            regex: '\d{10}',
            },
          ]
          },
        DK: {
          name: 'Denmark',
          code: 'DK',
          bban_format: '14n',
          iban_length: 18,
          account_number: [8, 17],
          regex: 'DK\d\d\d{14}',
          parts: %w[bank_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 16],
            regex: '\d{9}',
            },
            {
            part: 'checksum',
            indexes: [17, 17],
            regex: '\d{1}',
            },
          ]
          },
        DO: {
          name: 'Dominican Republic',
          code: 'DO',
          bban_format: '4a,20n',
          iban_length: 28,
          account_number: [8, 28],
          regex: 'DO\d\d[A-Z]{4}\d{20}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 27],
            regex: '\d{20}',
            },
          ]
          },
        TL: {
          name: 'East Timor',
          code: 'TL',
          bban_format: '19n',
          iban_length: 23,
          account_number: [7, 21],
          regex: 'TL\d\d\d{19}',
          parts: %w[bank_code checksum account_number],
          const_global_checksum: '38',
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 20],
            regex: '\d{14}',
            },
            {
            part: 'checksum',
            indexes: [21, 22],
            regex: '\d{2}',
            },
          ]
          },
        EG: {
          name: 'Egypt',
          code: 'EG',
          bban_format: '25n',
          iban_length: 29,
          branch_code: [8, 12],
          account_number: [12, 29],
          regex: 'EG\d\d\d{25}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [12, 28],
            regex: '\d{17}',
            },
          ]
          },
        SV: {
          name: 'El Salvador',
          code: 'SV',
          bban_format: '4a,20n',
          iban_length: 28,
          account_number: [8, 28],
          regex: 'SV\d\d[A-Z]{4}\d{20}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 27],
            regex: '\d{20}',
            },
          ]
          },
        EE: {
          name: 'Estonia',
          code: 'EE',
          bban_format: '16n',
          iban_length: 20,
          branch_code: [6, 8],
          account_number: [8, 19],
          regex: 'EE\d\d\d{16}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 5],
            regex: '\d{2}',
            },
            {
            part: 'branch_code',
            indexes: [6, 7],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [8, 18],
            regex: '\d{11}',
            },
            {
            part: 'checksum',
            indexes: [19, 19],
            regex: '\d{1}',
            },
          ]
          },
        FO: {
          name: 'Faroe Islands',
          code: 'FO',
          bban_format: '14n',
          iban_length: 18,
          account_number: [8, 17],
          regex: 'FO\d\d\d{14}',
          parts: %w[bank_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 16],
            regex: '\d{9}',
            },
            {
            part: 'checksum',
            indexes: [17, 17],
            regex: '\d{1}',
            },
          ]
          },
        FI: {
          name: 'Finland',
          code: 'FI',
          bban_format: '14n',
          iban_length: 18,
          account_number: [10, 17],
          regex: 'FI\d\d\d{14}',
          parts: %w[bank_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 9],
            regex: '\d{6}',
            },
            {
            part: 'account_number',
            indexes: [10, 16],
            regex: '\d{7}',
            },
            {
            part: 'checksum',
            indexes: [17, 17],
            regex: '\d{1}',
            },
          ]
          },
        FR: {
          name: 'France',
          code: 'FR',
          bban_format: '10n,11c,2n',
          iban_length: 27,
          branch_code: [9, 14],
          account_number: [14, 25],
          regex: 'FR\d\d\d{10}[a-zA-Z0-9]{11}\d{2}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 8],
            regex: '\d{5}',
            },
            {
            part: 'branch_code',
            indexes: [9, 13],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [14, 24],
            regex: '[a-zA-Z0-9]{11}',
            },
            {
            part: 'checksum',
            indexes: [25, 26],
            regex: '\d{2}',
            },
          ]
          },
        GE: {
          name: 'Georgia',
          code: 'GE',
          bban_format: '2c,16n',
          iban_length: 22,
          account_number: [6, 22],
          regex: 'GE\d\d[a-zA-Z0-9]{2}\d{16}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 5],
            regex: '[a-zA-Z0-9]{2}',
            },
            {
            part: 'account_number',
            indexes: [6, 21],
            regex: '\d{16}',
            },
          ]
          },
        DE: {
          name: 'Germany',
          code: 'DE',
          bban_format: '18n',
          iban_length: 22,
          account_number: [12, 22],
          regex: 'DE\d\d\d{18}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 11],
            regex: '\d{8}',
            },
            {
            part: 'account_number',
            indexes: [12, 21],
            regex: '\d{10}',
            },
          ]
          },
        GI: {
          name: 'Gibraltar',
          code: 'GI',
          bban_format: '4a,15c',
          iban_length: 23,
          account_number: [8, 23],
          regex: 'GI\d\d[A-Z]{4}[a-zA-Z0-9]{15}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 22],
            regex: '[a-zA-Z0-9]{15}',
            },
          ]
          },
        GR: {
          name: 'Greece',
          code: 'GR',
          bban_format: '7n,16c',
          iban_length: 27,
          branch_code: [7, 11],
          account_number: [11, 27],
          regex: 'GR\d\d\d{7}[a-zA-Z0-9]{16}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'branch_code',
            indexes: [7, 10],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [11, 26],
            regex: '[a-zA-Z0-9]{16}',
            },
          ]
          },
        GL: {
          name: 'Greenland',
          code: 'GL',
          bban_format: '14n',
          iban_length: 18,
          account_number: [8, 17],
          regex: 'GL\d\d\d{14}',
          parts: %w[bank_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 16],
            regex: '\d{9}',
            },
            {
            part: 'checksum',
            indexes: [17, 17],
            regex: '\d{1}',
            },
          ]
          },
        GT: {
          name: 'Guatemala',
          code: 'GT',
          bban_format: '4c,20c',
          iban_length: 28,
          account_number: [12, 28],
          account_type: [10, 12],
          currency_code: [8, 10],
          regex: 'GT\d\d[a-zA-Z0-9]{4}[a-zA-Z0-9]{20}',
          parts: %w[bank_code account_number account_type currency_code],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[a-zA-Z0-9]{4}',
            },
            {
            part: 'currency_code',
            indexes: [8, 9],
            regex: '[a-zA-Z0-9]{2}',
            },
            {
            part: 'account_type',
            indexes: [10, 11],
            regex: '[a-zA-Z0-9]{2}',
            },
            {
            part: 'account_number',
            indexes: [12, 27],
            regex: '[a-zA-Z0-9]{16}',
            },
          ]
          },
        HU: {
          name: 'Hungary',
          code: 'HU',
          bban_format: '24n',
          iban_length: 28,
          branch_code: [7, 11],
          account_number: [12, 27],
          regex: 'HU\d\d\d{24}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'branch_code',
            indexes: [7, 10],
            regex: '\d{4}',
            },
            {
            part: 'checksum',
            indexes: [11, 27],
            regex: '\d{17}',
            },
            {
            part: 'account_number',
            indexes: [12, 26],
            regex: '\d{15}',
            },
          ]
          },
        IS: {
          name: 'Iceland',
          code: 'IS',
          bban_format: '22n',
          iban_length: 26,
          branch_code: [6, 8],
          account_number: [10, 16],
          account_type: [8, 10],
          kennitala: [16, 26],
          regex: 'IS\d\d\d{22}',
          parts: %w[bank_code branch_code account_number account_type kennitala],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 5],
            regex: '\d{2}',
            },
            {
            part: 'branch_code',
            indexes: [6, 7],
            regex: '\d{2}',
            },
            {
            part: 'account_type',
            indexes: [8, 9],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [10, 15],
            regex: '\d{6}',
            },
            {
            part: 'kennitala',
            indexes: [16, 25],
            regex: '\d{10}',
            },
          ]
          },
        IQ: {
          name: 'Iraq',
          code: 'IQ',
          bban_format: '4a,15n',
          iban_length: 23,
          branch_code: [8, 11],
          account_number: [11, 23],
          regex: 'IQ\d\d[A-Z]{4}\d{15}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 10],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [11, 22],
            regex: '\d{12}',
            },
          ]
          },
        IE: {
          name: 'Ireland',
          code: 'IE',
          bban_format: '4c,14n',
          iban_length: 22,
          account_number: [14, 22],
          balance_account_number: [4, 8],
          regex: 'IE\d\d[a-zA-Z0-9]{4}\d{14}',
          parts: %w[bank_code account_number balance_account_number],
          parts_in_order: [
            {
            part: 'balance_account_number',
            indexes: [4, 7],
            regex: '[a-zA-Z0-9]{4}',
            },
            {
            part: 'bank_code',
            indexes: [8, 13],
            regex: '\d{6}',
            },
            {
            part: 'account_number',
            indexes: [14, 21],
            regex: '\d{8}',
            },
          ]
          },
        IL: {
          name: 'Israel',
          code: 'IL',
          bban_format: '19n',
          iban_length: 23,
          branch_code: [7, 10],
          account_number: [10, 23],
          regex: 'IL\d\d\d{19}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'branch_code',
            indexes: [7, 9],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [10, 22],
            regex: '\d{13}',
            },
          ]
          },
        IT: {
          name: 'Italy',
          code: 'IT',
          bban_format: '1a,10n,12c',
          iban_length: 27,
          branch_code: [10, 15],
          account_number: [15, 27],
          regex: 'IT\d\d[A-Z]{1}\d{10}[a-zA-Z0-9]{12}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'checksum',
            indexes: [4, 4],
            regex: '[A-Z]{1}',
            },
            {
            part: 'bank_code',
            indexes: [5, 9],
            regex: '\d{5}',
            },
            {
            part: 'branch_code',
            indexes: [10, 14],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [15, 26],
            regex: '[a-zA-Z0-9]{12}',
            },
          ]
          },
        JO: {
          name: 'Jordan',
          code: 'JO',
          bban_format: '4a,22n',
          iban_length: 30,
          branch_code: [8, 12],
          account_number: [12, 30],
          regex: 'JO\d\d[A-Z]{4}\d{22}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [12, 29],
            regex: '\d{18}',
            },
          ]
          },
        KZ: {
          name: 'Kazakhstan',
          code: 'KZ',
          bban_format: '3n,13c',
          iban_length: 20,
          account_number: [7, 20],
          regex: 'KZ\d\d\d{3}[a-zA-Z0-9]{13}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 19],
            regex: '[a-zA-Z0-9]{13}',
            },
          ]
          },
        XK: {
          name: 'Kosovo',
          code: 'XK',
          bban_format: '4n,10n,2n',
          iban_length: 20,
          account_number: [8, 20],
          regex: 'XK\d\d\d{4}\d{10}\d{2}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 19],
            regex: '\d{12}',
            },
          ]
          },
        KW: {
          name: 'Kuwait',
          code: 'KW',
          bban_format: '4a,22c',
          iban_length: 30,
          account_number: [8, 30],
          regex: 'KW\d\d[A-Z]{4}[a-zA-Z0-9]{22}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 29],
            regex: '[a-zA-Z0-9]{22}',
            },
          ]
          },
        LV: {
          name: 'Latvia',
          code: 'LV',
          bban_format: '4a,13c',
          iban_length: 21,
          account_number: [8, 21],
          regex: 'LV\d\d[A-Z]{4}[a-zA-Z0-9]{13}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 20],
            regex: '[a-zA-Z0-9]{13}',
            },
          ]
          },
        LB: {
          name: 'Lebanon',
          code: 'LB',
          bban_format: '4n,20c',
          iban_length: 28,
          account_number: [8, 28],
          regex: 'LB\d\d\d{4}[a-zA-Z0-9]{20}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 27],
            regex: '[a-zA-Z0-9]{20}',
            },
          ]
          },
        LY: {
          name: 'Libya',
          code: 'LY',
          bban_format: '21n',
          iban_length: 25,
          branch_code: [7, 10],
          account_number: [10, 25],
          regex: 'LY\d\d\d{21}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'branch_code',
            indexes: [7, 9],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [10, 24],
            regex: '\d{15}',
            },
          ]
          },
        LI: {
          name: 'Liechtenstein',
          code: 'LI',
          bban_format: '5n,12c',
          iban_length: 21,
          account_number: [9, 21],
          regex: 'LI\d\d\d{5}[a-zA-Z0-9]{12}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 8],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [9, 20],
            regex: '[a-zA-Z0-9]{12}',
            },
          ]
          },
        LT: {
          name: 'Lithuania',
          code: 'LT',
          bban_format: '16n',
          iban_length: 20,
          account_number: [9, 20],
          regex: 'LT\d\d\d{16}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 8],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [9, 19],
            regex: '\d{11}',
            },
          ]
          },
        LU: {
          name: 'Luxembourg',
          code: 'LU',
          bban_format: '3n,13c',
          iban_length: 20,
          account_number: [7, 20],
          regex: 'LU\d\d\d{3}[a-zA-Z0-9]{13}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 19],
            regex: '[a-zA-Z0-9]{13}',
            },
          ]
          },
        MK: {
          name: 'North Macedonia',
          code: 'MK',
          bban_format: '3n,10c,2n',
          iban_length: 19,
          account_number: [7, 17],
          regex: 'MK\d\d\d{3}[a-zA-Z0-9]{10}\d{2}',
          parts: %w[bank_code checksum account_number],
          const_global_checksum: '07',
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 16],
            regex: '[a-zA-Z0-9]{10}',
            },
            {
            part: 'checksum',
            indexes: [17, 18],
            regex: '\d{2}',
            },
          ]
          },
        MT: {
          name: 'Malta',
          code: 'MT',
          bban_format: '4a,5n,18c',
          iban_length: 31,
          branch_code: [8, 13],
          account_number: [13, 31],
          regex: 'MT\d\d[A-Z]{4}\d{5}[a-zA-Z0-9]{18}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 12],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [13, 30],
            regex: '[a-zA-Z0-9]{18}',
            },
          ]
          },
        MR: {
          name: 'Mauritania',
          code: 'MR',
          bban_format: '23n',
          iban_length: 27,
          branch_code: [9, 14],
          account_number: [14, 25],
          regex: 'MR\d\d\d{23}',
          parts: %w[bank_code branch_code checksum account_number],
          const_global_checksum: '13',
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 8],
            regex: '\d{5}',
            },
            {
            part: 'branch_code',
            indexes: [9, 13],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [14, 24],
            regex: '\d{11}',
            },
            {
            part: 'checksum',
            indexes: [25, 26],
            regex: '\d{2}',
            },
          ]
          },
        MU: {
          name: 'Mauritius',
          code: 'MU',
          bban_format: '4a,19n,3a',
          iban_length: 30,
          branch_code: [10, 12],
          account_number: [12, 24],
          currency_code: [27, 30],
          zero: [24, 27],
          regex: 'MU\d\d[A-Z]{4}\d{19}[A-Z]{3}',
          parts: %w[bank_code branch_code account_number currency_code zero],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 9],
            regex: '[A-Z][A-Z][A-Z][A-Z]\d\d',
            },
            {
            part: 'branch_code',
            indexes: [10, 11],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [12, 23],
            regex: '\d{12}',
            },
            {
            part: 'zero',
            indexes: [24, 26],
            regex: '\d{3}',
            },
            {
            part: 'currency_code',
            indexes: [27, 29],
            regex: '[A-Z]{3}',
            },
          ]
          },
        MC: {
          name: 'Monaco',
          code: 'MC',
          bban_format: '10n,11c,2n',
          iban_length: 27,
          branch_code: [9, 14],
          account_number: [14, 25],
          regex: 'MC\d\d\d{10}[a-zA-Z0-9]{11}\d{2}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 8],
            regex: '\d{5}',
            },
            {
            part: 'branch_code',
            indexes: [9, 13],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [14, 24],
            regex: '[a-zA-Z0-9]{11}',
            },
            {
            part: 'checksum',
            indexes: [25, 26],
            regex: '\d{2}',
            },
          ]
          },
        MD: {
          name: 'Moldova',
          code: 'MD',
          bban_format: '2c,18c',
          iban_length: 24,
          account_number: [6, 24],
          regex: 'MD\d\d[a-zA-Z0-9]{2}[a-zA-Z0-9]{18}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 5],
            regex: '[a-zA-Z0-9]{2}',
            },
            {
            part: 'account_number',
            indexes: [6, 23],
            regex: '[a-zA-Z0-9]{18}',
            },
          ]
          },
        ME: {
          name: 'Montenegro',
          code: 'ME',
          bban_format: '18n',
          iban_length: 22,
          account_number: [7, 20],
          regex: 'ME\d\d\d{18}',
          parts: %w[bank_code checksum account_number],
          const_global_checksum: '25',
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 19],
            regex: '\d{13}',
            },
            {
            part: 'checksum',
            indexes: [20, 21],
            regex: '\d{2}',
            },
          ]
          },
        NL: {
          name: 'Netherlands',
          code: 'NL',
          bban_format: '4a,10n',
          iban_length: 18,
          account_number: [8, 18],
          regex: 'NL\d\d[A-Z]{4}\d{10}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 17],
            regex: '\d{10}',
            },
          ]
          },
        NO: {
          name: 'Norway',
          code: 'NO',
          bban_format: '11n',
          iban_length: 15,
          account_number: [8, 14],
          regex: 'NO\d\d\d{11}',
          parts: %w[bank_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 13],
            regex: '\d{6}',
            },
            {
            part: 'checksum',
            indexes: [14, 14],
            regex: '\d{1}',
            },
          ]
          },
        PK: {
          name: 'Pakistan',
          code: 'PK',
          bban_format: '4c,16n',
          iban_length: 24,
          account_number: [8, 24],
          regex: 'PK\d\d[a-zA-Z0-9]{4}\d{16}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[a-zA-Z0-9]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 23],
            regex: '\d{16}',
            },
          ]
          },
        PS: {
          name: 'Palestinian territories',
          code: 'PS',
          bban_format: '4c,21n',
          iban_length: 29,
          account_number: [8, 29],
          regex: 'PS\d\d[a-zA-Z0-9]{4}\d{21}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[a-zA-Z0-9]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 28],
            regex: '\d{21}',
            },
          ]
          },
        PL: {
          name: 'Poland',
          code: 'PL',
          bban_format: '24n',
          iban_length: 28,
          branch_code: [7, 11],
          account_number: [12, 28],
          regex: 'PL\d\d\d{24}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'branch_code',
            indexes: [7, 10],
            regex: '\d{4}',
            },
            {
            part: 'checksum',
            indexes: [11, 11],
            regex: '\d{1}',
            },
            {
            part: 'account_number',
            indexes: [12, 27],
            regex: '\d{16}',
            },
          ]
          },
        PT: {
          name: 'Portugal',
          code: 'PT',
          bban_format: '21n',
          iban_length: 25,
          branch_code: [8, 12],
          account_number: [12, 23],
          regex: 'PT\d\d\d{21}',
          parts: %w[bank_code branch_code checksum account_number],
          const_global_checksum: '50',
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [12, 22],
            regex: '\d{11}',
            },
            {
            part: 'checksum',
            indexes: [23, 24],
            regex: '\d{2}',
            },
          ]
          },
        QA: {
          name: 'Qatar',
          code: 'QA',
          bban_format: '4a,21c',
          iban_length: 29,
          account_number: [8, 29],
          regex: 'QA\d\d[A-Z]{4}[a-zA-Z0-9]{21}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 28],
            regex: '[a-zA-Z0-9]{21}',
            },
          ]
          },
        RO: {
          name: 'Romania',
          code: 'RO',
          bban_format: '4a,16c',
          iban_length: 24,
          account_number: [8, 24],
          regex: 'RO\d\d[A-Z]{4}[a-zA-Z0-9]{16}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 23],
            regex: '[a-zA-Z0-9]{16}',
            },
          ]
          },
        LC: {
          name: 'Saint Lucia',
          code: 'LC',
          bban_format: '4a,24c',
          iban_length: 32,
          account_number: [8, 32],
          regex: 'LC\d\d[A-Z]{4}[a-zA-Z0-9]{24}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 31],
            regex: '[a-zA-Z0-9]{24}',
            },
          ]
          },
        SM: {
          name: 'San Marino',
          code: 'SM',
          bban_format: '1a,10n,12c',
          iban_length: 27,
          branch_code: [10, 15],
          account_number: [15, 27],
          regex: 'SM\d\d[A-Z]{1}\d{10}[a-zA-Z0-9]{12}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'checksum',
            indexes: [4, 4],
            regex: '[A-Z]{1}',
            },
            {
            part: 'bank_code',
            indexes: [5, 9],
            regex: '\d{5}',
            },
            {
            part: 'branch_code',
            indexes: [10, 14],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [15, 26],
            regex: '[a-zA-Z0-9]{12}',
            },
          ]
          },
        ST: {
          name: 'São Tomé and Príncipe',
          code: 'ST',
          bban_format: '21n',
          iban_length: 25,
          branch_code: [8, 12],
          account_number: [12, 25],
          regex: 'ST\d\d\d{21}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'account_number',
            indexes: [12, 24],
            regex: '\d{13}',
            },
          ]
          },
        SA: {
          name: 'Saudi Arabia',
          code: 'SA',
          bban_format: '2n,18c',
          iban_length: 24,
          account_number: [6, 24],
          regex: 'SA\d\d\d{2}[a-zA-Z0-9]{18}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 5],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [6, 23],
            regex: '[a-zA-Z0-9]{18}',
            },
          ]
          },
        RS: {
          name: 'Serbia',
          code: 'RS',
          bban_format: '18n',
          iban_length: 22,
          account_number: [7, 20],
          regex: 'RS\d\d\d{18}',
          parts: %w[bank_code checksum account_number],
          const_global_checksum: '35',
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 19],
            regex: '\d{13}',
            },
            {
            part: 'checksum',
            indexes: [20, 21],
            regex: '\d{2}',
            },
          ]
          },
        SC: {
          name: 'Seychelles',
          code: 'SC',
          bban_format: '4a,20n,3a',
          iban_length: 31,
          branch_code: [10, 12],
          account_number: [12, 28],
          currency_code: [28, 31],
          regex: 'SC\d\d[A-Z]{4}\d{20}[A-Z]{3}',
          parts: %w[bank_code branch_code account_number currency_code],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 9],
            regex: '[A-Z][A-Z][A-Z][A-Z]\d\d',
            },
            {
            part: 'branch_code',
            indexes: [10, 11],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [12, 27],
            regex: '\d{16}',
            },
            {
            part: 'currency_code',
            indexes: [28, 30],
            regex: '[A-Z]{3}',
            },
          ]
          },
        SK: {
          name: 'Slovakia',
          code: 'SK',
          bban_format: '20n',
          iban_length: 24,
          branch_code: [12, 14],
          account_number: [14, 24],
          account_prefix: [8, 12],
          regex: 'SK\d\d\d{20}',
          parts: %w[bank_code branch_code account_number account_prefix],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'account_prefix',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'branch_code',
            indexes: [12, 13],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [14, 23],
            regex: '\d{10}',
            },
          ]
          },
        SI: {
          name: 'Slovenia',
          code: 'SI',
          bban_format: '15n',
          iban_length: 19,
          branch_code: [6, 9],
          account_number: [9, 17],
          regex: 'SI\d\d\d{15}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 5],
            regex: '\d{2}',
            },
            {
            part: 'branch_code',
            indexes: [6, 8],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [9, 16],
            regex: '\d{8}',
            },
            {
            part: 'checksum',
            indexes: [17, 18],
            regex: '\d{2}',
            },
          ]
          },
        ES: {
          name: 'Spain',
          code: 'ES',
          bban_format: '20n',
          iban_length: 24,
          branch_code: [8, 12],
          account_number: [14, 24],
          regex: 'ES\d\d\d{20}',
          parts: %w[bank_code branch_code checksum account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '\d{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 11],
            regex: '\d{4}',
            },
            {
            part: 'checksum',
            indexes: [12, 13],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [14, 23],
            regex: '\d{10}',
            },
          ]
          },
        SD: {
          name: 'Sudan',
          code: 'SD',
          bban_format: '14n',
          iban_length: 18,
          account_number: [6, 18],
          regex: 'SD\d\d\d{14}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 5],
            regex: '\d{2}',
            },
            {
            part: 'account_number',
            indexes: [6, 17],
            regex: '\d{12}',
            },
          ]
          },
        SE: {
          name: 'Sweden',
          code: 'SE',
          bban_format: '20n',
          iban_length: 24,
          account_number: [7, 24],
          regex: 'SE\d\d\d{20}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 23],
            regex: '\d{17}',
            },
          ]
          },
        CH: {
          name: 'Switzerland',
          code: 'CH',
          bban_format: '5n,12c',
          iban_length: 21,
          account_number: [9, 21],
          regex: 'CH\d\d\d{5}[a-zA-Z0-9]{12}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 8],
            regex: '\d{5}',
            },
            {
            part: 'account_number',
            indexes: [9, 20],
            regex: '[a-zA-Z0-9]{12}',
            },
          ]
          },
        TN: {
          name: 'Tunisia',
          code: 'TN',
          bban_format: '20n',
          iban_length: 24,
          branch_code: [6, 9],
          account_number: [9, 22],
          regex: 'TN\d\d\d{20}',
          parts: %w[bank_code branch_code checksum account_number],
          const_global_checksum: '59',
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 5],
            regex: '\d{2}',
            },
            {
            part: 'branch_code',
            indexes: [6, 8],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [9, 21],
            regex: '\d{13}',
            },
            {
            part: 'checksum',
            indexes: [22, 23],
            regex: '\d{2}',
            },
          ]
          },
        TR: {
          name: 'Turkey',
          code: 'TR',
          bban_format: '5n,17c',
          iban_length: 26,
          account_number: [10, 26],
          zero: [9, 10],
          regex: 'TR\d\d\d{5}[a-zA-Z0-9]{17}',
          parts: %w[bank_code account_number zero],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 8],
            regex: '\d{5}',
            },
            {
            part: 'zero',
            indexes: [9, 9],
            regex: '[a-zA-Z0-9]{1}',
            },
            {
            part: 'account_number',
            indexes: [10, 25],
            regex: '[a-zA-Z0-9]{16}',
            },
          ]
          },
        UA: {
          name: 'Ukraine',
          code: 'UA',
          bban_format: '6n,19c',
          iban_length: 29,
          account_number: [10, 29],
          regex: 'UA\d\d\d{6}[a-zA-Z0-9]{19}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 9],
            regex: '\d{6}',
            },
            {
            part: 'account_number',
            indexes: [10, 28],
            regex: '[a-zA-Z0-9]{19}',
            },
          ]
          },
        AE: {
          name: 'United Arab Emirates',
          code: 'AE',
          bban_format: '3n,16n',
          iban_length: 23,
          account_number: [7, 23],
          regex: 'AE\d\d\d{3}\d{16}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 22],
            regex: '\d{16}',
            },
          ]
          },
        GB: {
          name: 'United Kingdom',
          code: 'GB',
          bban_format: '4a,14n',
          iban_length: 22,
          branch_code: [8, 14],
          account_number: [14, 22],
          regex: 'GB\d\d[A-Z]{4}\d{14}',
          parts: %w[bank_code branch_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[A-Z]{4}',
            },
            {
            part: 'branch_code',
            indexes: [8, 13],
            regex: '\d{6}',
            },
            {
            part: 'account_number',
            indexes: [14, 21],
            regex: '\d{8}',
            },
          ]
          },
        VA: {
          name: 'Vatican City',
          code: 'VA',
          bban_format: '3n,15n',
          iban_length: 22,
          account_number: [7, 22],
          regex: 'VA\d\d\d{3}\d{15}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 6],
            regex: '\d{3}',
            },
            {
            part: 'account_number',
            indexes: [7, 21],
            regex: '\d{15}',
            },
          ]
          },
        VG: {
          name: 'Virgin Islands, British',
          code: 'VG',
          bban_format: '4c,16n',
          iban_length: 24,
          account_number: [8, 24],
          regex: 'VG\d\d[a-zA-Z0-9]{4}\d{16}',
          parts: %w[bank_code account_number],
          parts_in_order: [
            {
            part: 'bank_code',
            indexes: [4, 7],
            regex: '[a-zA-Z0-9]{4}',
            },
            {
            part: 'account_number',
            indexes: [8, 23],
            regex: '\d{16}',
            },
          ]
          },
      }
    end
  end
end