# wssamples
Esempio di `middleware` da attivare su web service di ERP2.

## Installazione

1. Fermare il servizio `CSWERPWEBSRV_AXX_XXXXXXXXXX` o chiudere la console `SAMWebService_server.exe`
2. Aggiungere nella sezione moduli il nome del progetto senza il suffisso `WS`.
    ```
    [Moduli]
    M_Test=Plug-in middleware
    ```

4. Riavviare il servizio o la console



## Funzionamento

L'esempio gestisce due eventi, `OnAfterControllerAction` e `OnAfterRouting`.

### OnAfterRouting
Viene aggiunto un header personalizzato alla chiamata effettuata.
`X-PROUD-HEADER` con contenuto `Proudly served by Centro Software'.

![image](https://user-images.githubusercontent.com/51919683/224071842-17b2b721-d630-47a8-8135-0b5083407acf.png)


### OnAfterControllerAction
In inserimento, `POST`, dell'endpoint `/v1/artcla1` viene aggiunta la dicitura `altered` alla descrizione.

Body fornito:

![image](https://user-images.githubusercontent.com/51919683/224072140-13d9fd37-b62c-4014-8cac-69a806d7eba7.png)

Risultato dopo l'attivazione del `middleware`:

![image](https://user-images.githubusercontent.com/51919683/224072441-a830329a-2575-4677-92c1-5c85ac6b8ca7.png)

