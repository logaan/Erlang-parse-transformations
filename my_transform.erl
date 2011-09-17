-module(my_transform).
-compile(export_all).

parse_transform(Forms, _Options) ->
  erlang:display(Forms),
  ast_walk(Forms).

ast_walk([H|T]) ->
  [ast_walk(H)|ast_walk(T)];
ast_walk({function, _LN, greeting, 0, _Clauses}) ->
  greeting_function("Foo~n");
ast_walk(TopLevelThingy) ->
  TopLevelThingy.

greeting_function(Value) ->
  String = string(6, Value),
  Clause = clause(6, [], [], [String]),
  function(6, greeting, 0, [Clause]).

function(LN, Name, Arity, Clauses) ->
  {function, LN, Name, Arity, Clauses}.
clause(LN, Patterns, Guards, Bodies) ->
    {clause, LN, Patterns, Guards, Bodies}.
string(LN, Value) ->
  {string, LN, Value}.

% [
%   {attribute,1,file,{"./hello_world.erl",1}},
%   {attribute,1,module,hello_world},
%   {attribute,2,compile,export_all},
%   {function,5,start,0,[
%     {clause,5,[],[],[
%       {call,5,{remote,5,{atom,5,io},{atom,5,format}},[
%         {call,5,{atom,5,greeting},[]}
%       ]}
%     ]}
%   ]},
%   {function,6,greeting,0,[
%     {clause,6,[],[],[
%       {string,6,"Hello World~n"}
%     ]}
%   ]},
%   {eof,8}
% ]
