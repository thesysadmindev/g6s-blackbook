
# g6s-blackbook

g6s-blackbook is a simple FiveM ~~ESX~~ standalone resource, that logs all of a connecting player's identifiers to a table within the server database as well as the time they connected, and sends a message to a Discord channel via a webhook.

The possibilities are endless with this resource! It can be used to moderation on both FiveM servers and linked server forums (so if a player is banned from a server they are banned from the forum), clearing out player data for those who have not connected for a set time period, etc.

This resource is ~~functional, albeit not fully optimised~~ performs much better now and can be used independent of the framework usedm so feel free to fork the repo, make modifications and submit a pull request. If it all checks out I'll merge.

If you find any bugs or have any problems, open an issue and I'll see what I can do!

A MASSIVE thankyou to [@mortdudley](https://github.com/mortdudley) for the significant improvements in pull request #2 to convert to standalone, cleaning code, oxmysql support, debug changes and for his time.

Thanks,
The Sysadmin
## Deployment

To install this resource, all you need to do is copy it to your `resources` directory and add the line `ensure g6s-blackbook` to your `server.cfg` file, then run the included `sql.sql` file to create the table.



## Support

If you find any bugs or have any problems, open an issue and I'll see what I can do!


## Authors

- [@thesysadmin](https://github.com/thesysadmindev)

## Contributors

- [@mortdudley](https://github.com/mortdudley) - All the changes in pull request #2.


## License

MIT License

Copyright (c) 2023 - The Sysadmin (Discord: thesysadmin#0001)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

