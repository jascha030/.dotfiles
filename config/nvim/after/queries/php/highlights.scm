((class_declaration 
   name: (name) @className)
 (set! "priority" 105))

((class_declaration 
   modifier: (final_modifier) @modifier.final)
 (set! "priority" 105))

((scoped_call_expression
   scope: (relative_scope) @scope.relative)
 (set! "priority" 105))

((member_call_expression
   object: (variable_name) @object.var)
 (set! "priority" 105))

((class_constant_access_expression
  . [(name) (qualified_name)] @className
  (name) @constant)
   (set! "priority" 105))

(namespace_use_declaration) @namespaceUse
 ; (set! "priority" 105))
