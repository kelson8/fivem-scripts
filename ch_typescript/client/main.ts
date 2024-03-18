/// <reference path="C:\Users\kelson\AppData\Local\FiveM\FiveM.app\citizen\scripting\v8\index.d.ts" />

// https://docs.fivem.net/docs/scripting-manual/introduction/creating-your-first-script-javascript/
// Javascript api: https://github.com/d0p3t/fivem-js
// Typescript boilerplate code: https://github.com/project-error/fivem-typescript-boilerplate

// I'm not exactly sure how to use typescript on FiveM

RegisterCommand("jcar", (source, args, raw) => {
    emit("chat:addMessage"), {
        args: [`I wish I could spawn this ${(args.length > 0 ? `${args[0]} or` : ``)} adder but my owner was too lazy. :(`]
    };
}, false);