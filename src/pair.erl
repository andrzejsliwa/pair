%% See LICENSE for licensing information.
-module(pair).
-export([main/1]).

%% +-----------------------------------------------------------------+
%% | INTERFACE FUNCTIONS                                             |
%% +-----------------------------------------------------------------+

main(["help"]) -> usage();
main(["-h"])   -> usage();
main(["/h"])   -> usage();
main([]) ->
    handle_abort(
        fun() ->
            Config = config(),
            switch_git_config(get_value(my_name, Config),
                        get_value(my_email, Config)),
            io:format("Back to my identity.~n")
        end);
main([PairName]) ->
    handle_abort(
        fun() ->
            Pair  = get_value(PairName, config()),
            Left  = get_value(left, Pair),
            Right = get_value(right, Pair),
            Email = get_value(email, Pair),
            Name = io_lib:format("~s + ~s", [Left, Right]),
            switch_git_config(Name, Email),
            io:format("Pairing: ~s~n", [Name])
        end).

handle_abort(Fun) ->
    try
        Fun(),
        0
    catch
        exit:abort -> error
    end.

%% +-----------------------------------------------------------------+
%% | PRIVATE FUNCTIONS                                               |
%% +-----------------------------------------------------------------+

usage() ->
    io:format("./pair [name]: pair two people~n"),
    io:format("./pair       : switch to just me~n").

switch_git_config(Name, Email) ->
    case cmd("git config user.name '~s'", [Name]) of
        [] -> cmd("git config user.email ~s", [Email]);
        _ErrorOutput ->
            io:format("pair must be run inside of git repo!!!~n"),
            exit(abort)
    end.

cmd(Command, Args) ->
    os:cmd(io_lib:format(Command, Args)).

get_value(Key, PropList) ->
    case proplists:get_value(Key, PropList) of
        Atom when is_atom(Atom) -> get_value(Atom, config());
        Value -> Value
    end.

config() ->
    {ok, [[Home]]} = init:get_argument(home),
    ConfigPath = filename:join(Home, ".pair.config"),
    case filelib:is_file(ConfigPath) of
        true ->
            {ok, Config} = file:consult(ConfigPath),
            Config;
        false ->
            create_template(ConfigPath)
    end.

create_template(ConfigPath) ->
    ConfigTemplate =
    "%% define your identity...
     {my_name,  \"Andrzej Sliwa\"}.
     {my_email, \"andrzej.sliwa@i-tool.eu\"}.

     %% define your pairs...
     {\"an-ar\",  [{left, my_name}, {right, \"Artur Kowalski\"},
                {email, \"andrzej+artur@mydomain.com\"}]}.

     {\"an-jan\", [{left, my_email}, {right, \"Jan Kowalski\"},
                {email, \"andrzej+jan@mydomain.com\"}]}.",
    file:write_file(ConfigPath, ConfigTemplate),
    io:format("created example pair config: '~s'~n", [ConfigPath]),
    io:format("first update it and run pair again...~n"),
    exit(abort).
