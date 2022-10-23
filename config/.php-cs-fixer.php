<?php

declare(strict_types=1);

/**
 * Slightly edited config
 * based on config sets below.
 *
 * @PSR-1
 * @PSR-12
 * @PhpCSFixer
 */

use PhpCsFixer\Config;
use PhpCsFixer\ConfigInterface;
use PhpCsFixer\Finder;

$rules = new ArrayIterator([
    'blank_line_after_namespace'         => true,
    'blank_line_after_opening_tag'       => false, // due to WordPress
    'braces'                             => ['allow_single_line_anonymous_class_with_empty_body' => true],
    'class_definition'                   => ['space_before_parenthesis' => true],
    'compact_nullable_typehint'          => true,
    'constant_case'                      => true,
    'declare_equal_normalize'            => true,
    'elseif'                             => true,
    'encoding'                           => true,
    'full_opening_tag'                   => true,
    'function_declaration'               => true,
    'indentation_type'                   => true,
    'line_ending'                        => true,
    'lowercase_cast'                     => true,
    'lowercase_keywords'                 => true,
    'lowercase_static_reference'         => true,
    'method_argument_space'              => ['on_multiline' => 'ensure_fully_multiline'],
    'new_with_braces'                    => true,
    'no_blank_lines_after_class_opening' => true,
    'no_break_comment'                   => true,
    'no_closing_tag'                     => true,
    'no_leading_import_slash'            => true,
    'no_space_around_double_colon'       => true,
    'no_spaces_after_function_name'      => true,
    'no_spaces_inside_parenthesis'       => true,
    'no_trailing_whitespace'             => true,
    'no_trailing_whitespace_in_comment'  => true,
    'no_whitespace_in_blank_line'        => true,
    'ordered_class_elements'             => ['order' => ['use_trait']],
    'ordered_imports'                    => [
        'imports_order'  => ['class', 'function', 'const'],
        'sort_algorithm' => 'none',
    ],
    'return_type_declaration'            => true,
    'short_scalar_cast'                  => true,
    'single_blank_line_at_eof'           => true,
    'single_blank_line_before_namespace' => true,
    'single_class_element_per_statement' => ['elements' => ['property']],
    'single_import_per_statement'        => true,
    'single_line_after_imports'          => true,
    'single_trait_insert_per_statement'  => true,
    'switch_case_semicolon_to_colon'     => true,
    'switch_case_space'                  => true,
    'ternary_operator_spaces'            => true,
    'visibility_required'                => true,
    'not_operator_with_successor_space'  => true,
    'single_quote'                       => ['strings_containing_single_quote_chars' => true],
    'no_blank_lines_after_phpdoc'        => true,
    'class_attributes_separation'        => [
        'elements' => [
            'const'        => 'one',
            'method'       => 'one',
            'property'     => 'one',
            'trait_import' => 'none',
        ],
    ],
    'fully_qualified_strict_types'          => true,
    'no_unused_imports'                     => true,
    'cast_spaces'                           => true,
    'combine_consecutive_unsets'            => true,
    'combine_consecutive_issets'            => true,
    'concat_space'                          => ['spacing' => 'one'],
    'array_push'                            => true,
    'no_trailing_comma_in_singleline_array' => true,
    'trailing_comma_in_multiline'           => true,
    'array_syntax'                          => ['syntax' => 'short'],
    'align_multiline_comment'               => true,
    'array_indentation'                     => true,
    'backtick_to_shell_exec'                => true,
    'binary_operator_spaces'                => [
        'default'   => 'single_space',
        'operators' => [
            '='  => 'align_single_space_minimal',
            '=>' => 'align_single_space_minimal',
        ],
    ],
    'blank_line_before_statement' => [
        'statements' => [
            'break',
            'case',
            'continue',
            'declare',
            'default',
            'exit',
            'goto',
            'include',
            'include_once',
            'require',
            'require_once',
            'return',
            'switch',
            'throw',
            'try',
        ],
    ],
    'clean_namespace'                         => true,
    'doctrine_annotation_spaces'              => true,
    'echo_tag_syntax'                         => true,
    'empty_loop_body'                         => true,
    'empty_loop_condition'                    => true,
    'escape_implicit_backslashes'             => true,
    'explicit_indirect_variable'              => true,
    'explicit_string_variable'                => true,
    'function_typehint_space'                 => true,
    'general_phpdoc_tag_rename'               => ['replacements' => ['inheritDocs' => 'inheritDoc']],
    'heredoc_to_nowdoc'                       => true,
    'include'                                 => true,
    'increment_style'                         => true,
    'integer_literal_case'                    => true,
    'lambda_not_used_import'                  => true,
    'linebreak_after_opening_tag'             => true,
    'magic_constant_casing'                   => true,
    'magic_method_casing'                     => true,
    'method_chaining_indentation'             => true,
    'multiline_comment_opening_closing'       => true,
    'multiline_whitespace_before_semicolons'  => ['strategy' => 'no_multi_line'],
    'native_function_casing'                  => true,
    'native_function_type_declaration_casing' => true,
    'no_alias_language_construct_call'        => true,
    'no_alternative_syntax'                   => true,
    'no_binary_string'                        => true,
    'no_empty_comment'                        => true,
    'no_empty_phpdoc'                         => true,
    'no_empty_statement'                      => true,
    'no_extra_blank_lines'                    => [
        'tokens' => [
            'break',
            'case',
            'continue',
            'curly_brace_block',
            'default',
            'extra',
            'parenthesis_brace_block',
            'return',
            'square_brace_block',
            'switch',
            'throw',
            'use',
        ],
    ],
    'no_leading_namespace_whitespace'             => true,
    'no_mixed_echo_print'                         => true,
    'no_multiline_whitespace_around_double_arrow' => true,
    'no_null_property_initialization'             => true,
    'no_short_bool_cast'                          => true,
    'no_singleline_whitespace_before_semicolons'  => true,
    'no_spaces_around_offset'                     => true,
    'no_superfluous_elseif'                       => true,
    'no_superfluous_phpdoc_tags'                  => ['allow_mixed' => true, 'allow_unused_params' => true],
    'no_trailing_comma_in_list_call'              => true,
    'no_unneeded_control_parentheses'             => [
        'statements' => [
            'break',
            'clone',
            'continue',
            'echo_print',
            'return',
            'switch_case',
            'yield',
            'yield_from',
        ],
    ],
    'no_unneeded_curly_braces'                      => ['namespaces' => true],
    'no_unset_cast'                                 => true,
    'no_useless_else'                               => true,
    'no_useless_return'                             => true,
    'no_whitespace_before_comma_in_array'           => true,
    'normalize_index_brace'                         => true,
    'object_operator_without_whitespace'            => true,
    'operator_linebreak'                            => ['only_booleans' => true],
    'php_unit_fqcn_annotation'                      => true,
    'php_unit_internal_class'                       => true,
    'php_unit_method_casing'                        => true,
    'php_unit_test_class_requires_covers'           => true,
    'phpdoc_add_missing_param_annotation'           => true,
    'phpdoc_align'                                  => true,
    'phpdoc_annotation_without_dot'                 => true,
    'phpdoc_indent'                                 => true,
    'phpdoc_inline_tag_normalizer'                  => true,
    'phpdoc_no_access'                              => true,
    'phpdoc_no_alias_tag'                           => true,
    'phpdoc_no_empty_return'                        => true,
    'phpdoc_no_package'                             => true,
    'phpdoc_no_useless_inheritdoc'                  => true,
    'phpdoc_order'                                  => true,
    'phpdoc_order_by_value'                         => true,
    'phpdoc_return_self_reference'                  => true,
    'phpdoc_scalar'                                 => true,
    'phpdoc_separation'                             => true,
    'phpdoc_single_line_var_spacing'                => true,
    'phpdoc_summary'                                => true,
    'phpdoc_tag_type'                               => ['tags' => ['inheritDoc' => 'inline']],
    'phpdoc_to_comment'                             => false,
    'phpdoc_trim'                                   => true,
    'phpdoc_trim_consecutive_blank_line_separation' => true,
    'phpdoc_types'                                  => true,
    'phpdoc_types_order'                            => true,
    'phpdoc_var_annotation_correct_order'           => true,
    'phpdoc_var_without_name'                       => true,
    'protected_to_private'                          => true,
    'return_assignment'                             => true,
    'semicolon_after_instruction'                   => true,
    'simple_to_complex_string_variable'             => true,
    'single_line_comment_style'                     => false,
    'single_space_after_construct'                  => true,
    'space_after_semicolon'                         => ['remove_in_empty_for_expressions' => true],
    'standardize_increment'                         => true,
    'standardize_not_equals'                        => true,
    'switch_continue_to_break'                      => true,
    'trim_array_spaces'                             => true,
    'types_spaces'                                  => true,
    'unary_operator_spaces'                         => true,
    'whitespace_after_comma_in_array'               => true,
    'yoda_style'                                    => true,
]);

/**
 * Returns the Php-cs-fixer Configuration.
 * Creates a .cache dir if not already present.
 */
return (static function (Traversable $rules, ?string $cacheDirectory = null): ConfigInterface {
    if (! $cacheDirectory) {
        $cacheDirectory = __DIR__ . '/.cache';
    }

    if (! file_exists($cacheDirectory) && ! mkdir($cacheDirectory, 0700) && ! is_dir($cacheDirectory)) {
        throw new RuntimeException(
            sprintf('Directory "%s" was not created', $cacheDirectory)
        );
    }

    /**
     * @noinspection PhpUnnecessaryCurlyVarSyntaxInspection
     */
    return (new Config())
        ->setRules(iterator_to_array($rules))
        ->setRiskyAllowed(true)
        ->setCacheFile("{$cacheDirectory}/.php-cs-fixer.cache");
        //->setFinder(Finder::create()->exclude(['vendor', '.cache'])->in(__DIR__));
})($rules);
