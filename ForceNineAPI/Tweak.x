extern void FNAPIInitializeAPI(void);
extern void FNAPIInitializeWebSockets(void);

%ctor {
    FNAPIInitializeAPI();
    FNAPIInitializeWebSockets();
}