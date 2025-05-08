// const string PluginName = Meta::ExecutingPlugin().Name;
// const string MenuIconColor = "\\$f5d";
// const string PluginIcon = Icons::Cogs;
// const string MenuTitle = MenuIconColor + PluginIcon + "\\$z " + PluginName;

/*
    We need to patch a check on the number of genealogies too -- should be 0 to re-init.

Trackmania.exe+B25B93 - 74 51                 - jmp Trackmania.exe.text+B24BE6 { was je (x74 -> EB) -- tests if geneologies.len == 0 }
Trackmania.exe+B25B95 - 8B D8                 - mov ebx,eax
Trackmania.exe+B25B97 - 66 0F1F 84 00 00000000  - nop word ptr [rax+rax+00000000]
Trackmania.exe+B25BA0 - 48 8B 87 C0040000     - mov rax,[rdi+000004C0]
Trackmania.exe+B25BA7 - 41 B9 01000000        - mov r9d,00000001 { 1 }
Trackmania.exe+B25BAD - 48 8B 88 F0000000     - mov rcx,[rax+000000F0]

74 51 8B D8 66 0F 1F 84 00 00 00 00 00 48 8B 87 C0 04 00 00 41 B9 01 00 00 00 48 8B 88 F0 00 00 00

*/

const string Pattern_CheckGenealogiesLen = "74 ?? 8B D8 66 0F 1F 84 00 00 00 00 00 48 8B 87 ?? 04 00 00";
MemPatcher@ Patch_GenealogyCheck = MemPatcher(Pattern_CheckGenealogiesLen, {0}, {"EB"}, {"74"}).AutoLoad();

void NotifyError(const string &in msg) {
    warn(msg);
    UI::ShowNotification(Meta::ExecutingPlugin().Name + ": Error", msg, vec4(.9, .3, .1, .3), 15000);
}
