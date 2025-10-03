function format
    set lang $argv[1]
    switch $lang
        case hs
            fd -Ie hs -X stylish-haskell -i {}
        case py
            fd -Ie py -X ruff format --config ~/.config/ruff.toml {}
        case nim
            fd -Ie nim -X nimpretty --maxLineLen:89 --indent:3 {}
        case md
            fd -Ie md -X prettier -uw --print-width 79 --tab-width 3 {}
        case html
            fd -Ie html -X prettier -uw --print-width 79 --tab-width 3 {}
        case xml
            fd -Ie xml -x xq --indent 3 <{} >tmp.xml && mv tmp.xml {}
        case '*'
            echo "Unknown or unsupported language: $lang"
            return 1
    end
end
